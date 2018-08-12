---
title:  "Close locked files on Windows network share"
tags: [windows]
image: /assets/2016-06-04-close-locked-files.png
---

Another user can lock a file on your system when he has opened that file using a Windows network share.
This can deny file system operation like moving or deleting, but You can force a close of those files.

<!--more-->

On a Windows desktop:

* Open `Computer Management`. This requires administrative rights.  One way to do this is by opening a Windows Explorer, 
  right-click on `My Computer` (or `This PC`), and select the menu-item `Manage`.
* In the left-pane tree, open `Computer Management` &rarr; `System Tools` &rarr; `Shared Folders`
* You can select the files you want to close, right-click and select ´Close Open File`.
  ![Screenshot desktop](/assets/2016-06-04-close-locked-files-3.png)

On a Windows Server:

* Open the `Server Manager`
* In the left-pane tree, open `Server Manager` &rarr; `Roles` &rarr; `File Services` &rarr; 
  `Share and Storage Management`.
  ![Screenshot desktop](/assets/2016-06-04-close-locked-files-1.png)  
* You can select the files you want to close and click on `Close Selected`.
  ![Screenshot desktop](/assets/2016-06-04-close-locked-files-2.png)

