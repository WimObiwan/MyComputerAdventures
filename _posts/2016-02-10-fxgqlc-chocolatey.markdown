---
title:  "FxGqlC Chocolatey package"
tags: [chocolatey, fxgqlc]
image: /assets/2016-02-10-fxgqlc-chocolatey.png
---

Good News! FxGqlC is now also accepted as official Chocolatey package.

<!--more-->

So, from now on, the easiest way to install FxGqlC on Windows is:

* Open a PowerShell window as administrator
* If you're not already using Chocolatey, install it by running:

  ```bash
  iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
  ```
  
* Install FxGqlC by running:

  ```bash
  choco install fxgqlc
