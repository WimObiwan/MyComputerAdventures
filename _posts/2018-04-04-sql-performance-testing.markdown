---
title: "SQL Server performance testing"
tags: [sql, performance]
image: /assets/2018-04-04-sql-server-performance.png
---

With your databases stored on SSD-disks on fast development machines, it becomes difficult to reproduce performance problems that occur on customer machines.  This post gives some tricks to allow troubleshoot performance problems, while still using your fast development machine.

<!--more-->

Store your database data file on an external USB disk
===

Before you detache the USB drive, you should:

* In SQL Server Management Studio: Bring the database offline (or detach the database)
* In Windows: Prepare the USB drive to detach (as you should always do with USB-disks)

If you happen to forget one of these, it can happen that the database gets corrupted.  When this happens, you can correct the problems by running a `DBCC CHECKDB` as in single-user mode: 

{% highlight sql %}
ALTER DATABASE [MyDatabase-USBDISK]
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO
 
DBCC CHECKDB;
GO
 
ALTER DATABASE [MyDatabase-USBDISK]
SET MULTI_USER;
GO
{% endhighlight %}

Prevent caching of query data in memory
===

A slow USB disk will make the query slow once, but after that, the query will fast because the data is cached in (much faster) memory.  To prevent this, you can run this query:

{% highlight sql %}
WHILE 1=1 -- repeat forever
BEGIN
    -- clear query cache
    DBCC FREEPROCCACHE;
    -- clear data cache
    DBCC DROPCLEANBUFFERS;
    -- wait 3s
    WAITFOR DELAY '00:00:03'
END
GO
{% endhighlight %}

This query will run forever unless an error happens (e.g. connection issue) or the query is canceled by the user.
