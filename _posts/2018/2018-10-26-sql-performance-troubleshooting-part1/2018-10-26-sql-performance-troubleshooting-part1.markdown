---
title: "SQL Server performance troubleshooting - Part 1"
tags: [sql, performance]
image: sql-server-performance.png
---

SQL Server data/log file fragmentation can increase delays on 

<!--more-->

There are 2 types of fragmentations:

* Fragmentation of the data/log files on file system level.

   * The cause of physical file fragmentation is mainly the *auto-grow* feature in SQL Server.  This causes the data or log files to be extended in chunks whenever more space is needed.  Using auto-grow is discouraged: it causes heavy fragmentation, and causes a performance hit every time the auto-grow is performed. I have even seen a yoyo-effect when SQL command execution time is set to a low value: an `INSERT` command causes an grow operation which takes a long time, causing the `INSERT` to time out, and causing the grow to be reverted.  The `INSERT` was then retried forever by the application, every time with the same result.
   * Disk fragmentation is only relevant for HDDs.  There is a huge *seek time penalty* compared to sequential reads, which makes reads a lot more efficient when they can be done sequentially.
   * Defragmenting SSDs is discouraged.  There is no such *seek time penalty*.  Moreover, defragmenting will decrease the lifetime of your SSDs.  [More information on StackOverflow/SuperUser](https://superuser.com/q/97071).

* Fragmentation of the pages inside the data/log.

   * SQL Server uses pages (of 8KB), grouped in extents (of 64KB), to allocate space inside the files ([cfr. Microsoft](https://docs.microsoft.com/en-us/sql/relational-databases/pages-and-extents-architecture-guide)).  Event when the files are not fragmented physically, the pages/extents will get fragmented over time.
   * Pages of indexes should not be completely full, since this will decrease performance because the first insert (or key update) on the page will cause a page split.  This is controlled by the *Fill factor* ([cfr Brentozar](https://www.brentozar.com/archive/2013/04/five-things-about-fillfactor/)).

Backup
---

Don't forget to make a fresh backup before doing these operations.

The easiest way to do it is using SQL Server Management Studio:

* Open the backup window:  
  ![Open the backup window](backup-1.png)

   1. Right click on your database
   2. Open the *Tasks* submenu
   3. Click *Back Up...*

* Configure and start the backup:  
  ![Configure and start the backup](backup-2.png)

  1. Don't forget to enable *Copy-only backup*.  This is needed to prevent messing up with existing (transaction log &amp; differential) backups, which would get corrupt when a new full backup is done outside the schedule.
  2. Set a new location for the backup by removing the existing one, and adding a new one.
  3. Click the *OK* button to start the backup.

Physical file fragmentation
---

(This doesn't apply to SSDs.  Only do physical file defragmentation on regular HDDs!)



There are several options to defragment this.

* One way to do it is running a defragmentation of the complete disk from within *Windows Explorer.  The advantage is that there are no extra tools needed.  The drawback is that this defragments all files (not only the data/log files).  If your data & log files are stored on different disks (which is a good practice), this needs to be repeated for every disk.  Be aware that there can be multiple data files.  

  ![Defragment disk](defragment-disk-1.png)

  1. Open *Windows Explorer* and right click on the drive where the files are stored.
  2. Click *Properties* to open the disk properties.

  ![Defragment disk](defragment-disk-2.png) 

  1. Go to the *Tools* tab
  2. Click *Optimize*, and click *Optimize* again on the next window to start the defragmentation.

  A last remark when using SSDs: The *Optimize* process on SSD disks doesn't do a defragmentation, but just sends a *trim* to reclaim free blocks.  So this doesn't apply to this article on performance.  [More info on StackOverflow/Superuser](https://superuser.com/a/479211)

* There is a way to run defragmentation on file level, which requires the SysInternals `contig.exe` tool.  
Two ways to get it:

  * By downloading it from the [SysInternals website](https://docs.microsoft.com/en-us/sysinternals/downloads/contig).
  * Or by installing using [Chocolatey](https://chocolatey.org/packages/sysinternals):

    {% highlight powershell %}
    choco install sysinternals
    {% endhighlight %}

  Next you analyze individual data/log files by running:

  {% highlight powershell %}
  contig.exe -a '&lt;filepath&gt;'
  {% endhighlight %}

  ![contig.exe -a](defragment-contig-1.png)

  Doing the actual defragmentation can be done by removing the `-a`:

  {% highlight powershell %}
  contig.exe '&lt;filepath&gt;'
  {% endhighlight %}

  ![contig.exe -a](defragment-contig-2.png)

  In this example, the defragmentation has turned the 14 original fragments into 1 contiguous fragment. In a more realistic scenario which was executed at a customer, almost 9000 fragments were turned into 2 fragments.  
  The `contig.exe` tool doesn't report any progress of the file defragmentation.  But the progress can be *monitored* by running `contig.exe` using `-a` in another window, where you will see that the fragments are decreasing rapidly.  
  In theory, it is perfectly safe to *kill* a running `contig.exe`, by pressing `Ctrl-C`.  The tool can be restarted later on, causing it to continue where it was stopped.
  It is unclear if `contig.exe` is as smart as the whole-disk *Optimize* tool mentioned above, with regard to SSDs.  So I don't recommend running it on SSDs.
  

Logical file fragmentation
---

In this topic, we are talking about index fragmentation.  But be aware that (in the likely case that the table has a clustered index), a table is just a special kind of index.  
A SQL Server index can be considered fragmented when it has more than 5% fragmentation.  Tables smaller than 1000 pages will normally not benifit from defragmentation.

The most fragmented indexes can be found by running this query on your database:  (to be repeated per database)

{% highlight sql %}
WITH fragmented_indexes AS
(
	SELECT 
		s.name [schema], t.name [table], i.name [index], ips.page_count, 
		ips.avg_fragmentation_in_percent, 
		ips.page_count * ips.avg_fragmentation_in_percent weight
	FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) ips
		JOIN sys.indexes i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
		JOIN sys.tables t ON i.object_id = t.object_id
		JOIN sys.schemas s ON t.schema_id = s.schema_id
	WHERE page_count >= 1000 and avg_fragmentation_in_percent >= 5
)
SELECT * 
FROM fragmented_indexes
ORDER BY weight DESC;
{% endhighlight %}

Or if you have many indexes on many tables, the next query can be used to show a list per table:

{% highlight sql %}
WITH fragmented_indexes AS
(
	SELECT 
		s.name [schema], t.name [table], i.name [index], ips.page_count, 
		ips.avg_fragmentation_in_percent, 
		ips.page_count * ips.avg_fragmentation_in_percent weight
	FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) ips
		JOIN sys.indexes i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
		JOIN sys.tables t ON i.object_id = t.object_id
		JOIN sys.schemas s ON t.schema_id = s.schema_id
	WHERE page_count >= 1000 and avg_fragmentation_in_percent >= 5
)
SELECT 
	[schema], [table], COUNT(1) indexes, SUM(page_count) page_count,  
	AVG(avg_fragmentation_in_percent) avg_fragmentation_in_percent, 
	SUM(weight) weight
FROM fragmented_indexes
GROUP BY [schema], [table]
ORDER BY weight DESC;
{% endhighlight %}

Defragmenting indexes: indexes can be Reorganized (recommended for low fragmentation, e.g. between 5% and 20%), or Rebuild (recommended for heavy fragmentation, e.g. more than 20%).  Index Reorganization can be done on-line.  Index Rebuilds can only be done on-line on SQL Server Enterprise Edition.


* On SQL Server Standard Edition (or above), you should run a Maintenance plan to reorganize/rebuild indexes regularly, e.g. every week.
* Alternatively, [Ola Hallengren](https://ola.hallengren.com/sql-server-index-and-statistics-maintenance.html) has maintenance scripts that can used even on SQL Server Express Edition where no SQL Server Agent is available.  (Kohera)[https://kohera.be/blog/sql-server/providing-a-sql-server-express-edition-with-a-solid-maintenance-plan/] shows how to use the Windows Task manager as an alternative.
* Indexes can be defragmentated manually, per table or index, by running REORGANIZE or REBUILD on indexes.  
  ![Reorganize Rebuild](reorganize-rebuild.png)

  1. Expland the table entry in the Object Explorer.
  2. Right click on the Indexes node (to run the operation on all indexes) or an individual index under the Indexes node (to run the operation on a single index).
  3. Select Rebuild or Reorganize.
