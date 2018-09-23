---
title: "Jenkins GIT polling blocked "
tags: [jenkins/hudson]
image: jenkins-git-polling-blocked-0.png
---

This post contains a dirty workaround for blocked Git SSH processes on a Hudson/Jenkins build server.

<!--more-->

We were experiencing this error on our Windows Hudson/Jenkins build servers multiple times a week:
```
There are more SCM polling activities scheduled than handled, so the threads are not keeping up with the demands. 
Check if your polling is hanging, and/or increase the number of threads if necessary.
```

We are using GIT, and apparently, the cause of the blocked GIT pollings was a hanging `SSH.exe` process.

A few posts indicated that others are experiencing the same or similar problems:

* [Jenkins-14046: git operations occasionally hang in Jenkins on Windows](https://issues.jenkins-ci.org/browse/JENKINS-14046)
* [StackOverflow: git operations occasionally hang in Jenkins on Windows](http://stackoverflow.com/questions/10732940/git-operations-occasionally-hang-in-jenkins-on-windows)

The proposed solutions didn't help me:

* Reinstalled Jenkins and GIT.
* Installed plink.exe/pageant.exe, and set GIT_SSH.
* Played around with the temporary directory.

As a workaround, the only thing that helped (besides rebooting) was killing the blocked `ssh.exe` process. 
So currently, I'm running a Windows *Scheduled task* that kills blocked `SSH.exe` processes every 5 minutes:

```bash
Get-Process | where { $_.ProcessName -eq 'SSH' -and $_.StartTime -lt (Get-Date).AddMinutes(-2) } | Stop-Process -Force
```

Configuration of the Windows Scheduled task:

![Screenshot 1](jenkins-git-polling-blocked-1.png)
![Screenshot 2](jenkins-git-polling-blocked-2.png)

As argument, you can specify:

```
-Command "& { Get-Process | where { $_.ProcessName -eq 'SSH' -and $_.StartTime -lt (Get-Date).AddMinutes(-2) } | Stop-Process -Force }"
```

With Powershell 3 (as administrator), you can use the built-in support for ScheduledJobs:

```bash
$trigger = New-JobTrigger -At (get-date) -Once -RepetitionInterval (New-TimeSpan -Minutes 5) -RepetitionDuration ([TimeSpan]::MaxValue)
Register-ScheduledJob -Name Jenkins-Workaround-BlockedSsh -ScriptBlock { Get-Process | where { $_.ProcessName -eq 'SSH' -and $_.StartTime -lt (Get-Date).AddMinutes(-2) } | Stop-Process -Force } -Trigger $trigger
```

That's all you need to do!

```
Output:
Id         Name            JobTriggers     Command                                  Enabled 
--         ----            -----------     -------                                  ------- 
40         Jenkins-Work... 1                Get-Process | where { $_.ProcessName... True 

# Get list of all ScheduledJobs:
Get-ScheduledJob *   # gets a list of all jobs

#Output:
Id         Name            JobTriggers     Command                                  Enabled 
--         ----            -----------     -------                                  ------- 
... 
40         Jenkins-Work... 1                Get-Process | where { $_.ProcessName... True  

# Get properties of the newly created ScheduledJob:
Get-ScheduledJob -Id 40 | Format-Custom -Depth 1  # replace id 40 with the correct one 
class ScheduledJobDefinition 
{
  ...
  Definition =
    class JobDefinition
    {
      Name = Jenkins-Workaround-BlockedSsh
      JobSourceAdapterType = Microsoft.PowerShell.ScheduledJob.ScheduledJobSourceAdapter
      ModuleName = PSScheduledJob       JobSourceAdapterTypeName = ScheduledJobSourceAdapter
      Command =  Get-Process | where { $_.ProcessName -eq 'SSH' -and $_.StartTime -lt (Get-Date).AddMinutes(-2) } | Stop-Process -Force
      InstanceId = dd6cfd1d-5cc1-4ecc-8172-93f09ff0beda
      CommandInfo =
    }
  Options =
    class ScheduledJobOptions
    {
      StartIfOnBatteries = False
      StopIfGoingOnBatteries = True
      WakeToRun = False
      StartIfNotIdle = True
      StopIfGoingOffIdle = False
      RestartOnIdleResume = False
      IdleDuration = 00:10:00
      IdleTimeout = 01:00:00
      ShowInTaskScheduler = True
      RunElevated = False
      RunWithoutNetwork = True
      DoNotAllowDemandStart = False
      MultipleInstancePolicy = IgnoreNew
      JobDefinition = Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition
    }
  Credential =
  JobTriggers =
    [
      Microsoft.PowerShell.ScheduledJob.ScheduledJobTrigger
    ]
  Id = 40
  GlobalId =
    class Guid
      {
        Guid = 22ef5ef5-06b6-41de-99dc-6fc5b6fee6b6
      }
  Name = Jenkins-Workaround-BlockedSsh
  Command =  Get-Process | where { $_.ProcessName -eq 'SSH' -and $_.StartTime -lt (Get-Date).AddMinutes(-2) } | Stop-Process -Force
  ExecutionHistoryLength = 32
  Enabled = True
  ...
}
```

After about 5 minutes, the first Job will be created:

```bash
Get-Job | where { $_.Name -match 'Jenkins' }
Get-Job -Id 481 | Format-Custom -Depth 1
```