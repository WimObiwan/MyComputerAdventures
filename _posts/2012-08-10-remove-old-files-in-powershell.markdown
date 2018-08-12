---
title: "Cleanup old files from your harddisk using PowerShell"
tags: [windows, powershell]
image: /assets/2012-08-10-powershell.png
---

A PowerShell script to remove old files.

<!--more-->

This script removes all files from the current folder (in this case 'c:\temp') that are not accessed during the last 3 months.

A confirmation is asked because `-Confirm` is included. When files cannot be removed (e.g. files in use), the errors are ignored because `-ErrorAction Continue` is specified.

  {: .language-bash}
    Get-ChildItem -Recurse | where { $_.LastAccessTime -lt (Get-Date).AddMonths(-3) } `
      | Remove-Item -Recurse -Force -Confirm -ErrorAction Continue

*(Split over multiple lines for readability.)*

![Screenshot](/assets/2012-08-10-powershell-remove-files.png "Screenshot")
