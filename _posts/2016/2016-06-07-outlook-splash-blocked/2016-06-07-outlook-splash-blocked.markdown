---
title:  "Outlook stuck on splash screen"
tags: [windows, msoffice]
image: outlook.png
---

After running Microsoft Outlook for years without problems, it won't start anymore 
after a reboot.

<!--more-->

This problem happened with Microsoft Outlook 2016, connected to 
an Office 365 online account.  But I assume it is rather unrelated to the version.  

After a reboot, I launched Outlook, and this was the result:

![Outlook Splash](outlook-splash.png)

The splash screen was shown infinitely, while indicating the status
```Processing...```.

_Repairing_ the OST file with the tools from the Microsoft website didn't help.

This was the only thing that helped:

* kill outlook
* restart outlook in _safe_ mode (this succeeds immediately)
* close outlook
* restart outlook (which now also succeeds immediately)

A few PowerShell commands to do this:

```bash
# Kill outlook (or click the 'x' in the right/top corner of the splash screen)
(Get-Process outlook).Kill()

# Find the location of outlook.exe
$reg = 'HKLM:\SOFTWARE\Classes\Outlook.Application\CLSID'
$outlook_clsid = (Get-ItemProperty $reg).'(default)'
$reg = "HKLM:\SOFTWARE\Classes\CLSID\$outlook_clsid\LocalServer32"
$outlook_exe = (Get-ItemProperty $reg).'(default)'

# Start outlook in safe mode
. $outlook_exe /safe
```
