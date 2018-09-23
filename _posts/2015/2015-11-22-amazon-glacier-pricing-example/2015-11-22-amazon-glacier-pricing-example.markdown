---
title: "Amazon Glacier pricing example"
tags: [aws]
image: amazon-glacier.png
---

A price calculation example to store your data on Amazon Glacier, and a few caveats that you need to consider.

<!--more-->

Let's say you want to *backup 100 GB* of data (= +/- 25 DVDs), e.g. 1000 files of 100 MB. 

* Backup:
  To back up your data
   * Incoming Transfers: free
   * Upload requests: 1000 x (0.050$ / 1000 requests) = 0.05$ is virtually free
   * **Total Backup cost: 0.05$**, so virtually free
* Storage:
  To keep your data at Amazon Glacier
   * 100 GB x (0.007$ / GB / month) = 0.7$ / month
   * **Total storage cost: 8.40$ / year**
* Restore: 
  (let's say you want to download 10GB of 100GB, spread over a month: 3 files per day)
   * Restore: 5% of 100GB (5GB) free, remainder:
      * 5GB x 0.010$ = 0.05$
   * Outgoing Transfers: 1GB for free, remainder:
      * 9 GB x 0.09$ = 0.81$
   * Requests: 100 x 0.05$ / 1000 requests = 0.005$
   * **Total restore cost = 0.87$**

And for 1 TB of data:

* Backup: 0.50$
* Storage: 10$/month or 84$/year
* Restore of 10%: 9.46$

It doesn't matter if you use Amazon Glacier directly, or via the "Glacier storage class" in Amazon S3. 
In the latter case, the Glacier costs are advertised under S3.

To have the cheapest costs, you should optimize between:

* The number of objects: **LESS objects is BETTER**, since many objects cost more than less objects (both for backup and restore).
  E.g. if you use files of 100 KB instead of 100 MB, the cost for backup is 50$ instead of 0.05$.
* The size of the objects: **SMALLER objects is BETTER**.
  To be able to spread the download over a month, you should keep the size of the objects below 1/30th 
  of 5% of your total size. So, at least 600 files if they are equal in size.
  E.g. if you use 10 files of 10 GB instead of 100MB, the cost for restoring 10% (1 file) is 0.78$ instead 
  of 0.05$

So, the only thing you need to prevent is storing many small objects on Glacier.

Some more remarks:

* By far the easiest way to get started with Glacier, is using the Glacier storage class in Amazon S3.
  This gives you an easy to use GUI to store and retrieve files to/from Glacier, with a small extra temporary 
  S3 cost.
  Transfers from S3 to Glacier are always free of charge, so the biggest extra cost is the storage cost while 
  the data is on S3 instead of Glacier.
  You can configure S3 to automatically move an uploaded file to Glacier after e.g. 1 day.
* For a restore, you need to be patient: it takes 4 hours until your data is available.
* The fault tolerance is remarkable: 11 nines (99.999999999%). This is huge. Especially compared with 
  portable harddisks (99%?) or DVDs (99.999%?)...
* The cost of certain datacenters (e.g. Frankfurt) is higher. Ireland has now the same costs as the US locations.

