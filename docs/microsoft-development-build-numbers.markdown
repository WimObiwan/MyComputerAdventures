---
layout: page
sitemap:
    priority: 0.9
    changefreq: 'weekly'
    lastmod: 2016-11-14
---

It is quite a challenge to understand the versions and build numbers of the Microsoft build chain.  This post tries to list them up...

<!--more-->

# Major versions of Visual Studio

| Name                | Version | .NET[*](https://en.wikipedia.org/wiki/Microsoft_Visual_Studio#History) | C++ Compiler |
| ------------------- | ------- | --------------------- | ---- |
| Visual Studio 2017  | 15      | 2.0 - 4.6.2; Core 1.0 | 19   |
| Visual Studio 2015  | 14      | 2.0 - 4.6             | 19   |
| Visual Studio 2013  | 12      | 2.0 - 4.5.2           | 18   |
| Visual Studio 2012  | 11      | 2.0 - 4.5.2           | 17   |
| Visual Studio 2010  | 10      | 2.0 - 4.0             | 16   |
| Visual Studio 2008  | 9       | 2.0 - 3.5             | 15   |
| Visual Studio 2005  | 8       | 2.0 - 3.0             | 14   |
| Visual Studio 2003  | 7.1     | 1.1                   | 13.1 |
| Visual Studio .net  | 7       | 1.0                   | 13   |
| Visual C++ 6.0      |         |                       | 12   |
| Visual C++ 97       | 5       |                       | 11   |
| Visual C++ 4.2      |         |                       | 10.2 |

# Visual Studio 2017 build numbers

| Date       | Name                            | IDE Version    | C++ Compiler  |
| ---------- | ------------------------------- | -------------- | ------------- |
| 2017-03-14 | Visual Studio 2017              | 15.0.26228.09  | 19.10.25017.0 |
| 2017-03-07 | Visual Studio 2017              | 15.0.26228.04  | 19.10.25017.0 |

```
dir "C:\Program Files (x86)\Microsoft Visual Studio" -Recurse -Filter "cl.exe" | Get-FileVersionInfo
```

[Visual Studio 2017 Release notes](https://www.visualstudio.com/en-us/news/releasenotes/vs2017-relnotes)

# Visual Studio 2015 build numbers

| Date       | Name                            | IDE Version   | C++ Compiler  |
| ---------- | ------------------------------- | ------------- | ------------- |
| 2016-09-14 | Visual Studio 2015 Update 3 "d" | 14.0.25431.01 | 19.00.24213.1 or 19.00.24215.1? |
| 2016-08-02 | Visual Studio 2015 Update 3 "c" | 14.0.25425.01 |               |
| 2016-07-20 | Visual Studio 2015 Update 3 "b" | 14.0.25424.00 |               |
| 2016-07-12 | Visual Studio 2015 Update 3 "a" | 14.0.25422.01 |               |
| 2016-06-27 | Visual Studio 2015 Update 3     | 14.0.25420.01 | 19.00.24210   |
| 2016-05-23 | Visual Studio 2015 Update 2 "c" | 14.0.25132.0  |               |
| 2016-05-04 | Visual Studio 2015 Update 2 "b" | 14.0.25130.0  |               |
| 2016-04-11 | Visual Studio 2015 Update 2 "a" | 14.0.25126.03 |               |
| 2016-03-30 | Visual Studio 2015 Update 2     | 14.0.25125.03 |               |
| 2016-02-09 | Visual Studio 2015 Update 1 "c" | 14.0.24730.02 |               |
| 2016-01-19 | Visual Studio 2015 Update 1 "b" | 14.0.24728.02 |               |
| 2015-12-14 | Visual Studio 2015 Update 1 "a" | 14.0.24723.02 |               |
| 2015-11-30 | Visual Studio 2015 Update 1     | 14.0.24720.00 |               |
| 2015-07-20 | Visual Studio 2015              | 14.0.23107.0  |               |

[Visual Studio 2015 Update 3](https://msdn.microsoft.com/en-us/library/mt752379.aspx) - [KB3165756](http://go.microsoft.com/fwlink/?LinkID=816878)  
[Visual Studio 2015 Update 2](https://msdn.microsoft.com/en-us/library/mt695655.aspx) - [KB3151378](http://go.microsoft.com/fwlink/?LinkID=780690)  
[Visual Studio 2015 Update 1](https://msdn.microsoft.com/en-us/library/mt634751.aspx) - [KB3110221](http://go.microsoft.com/fwlink/?LinkId=724029)  

# Visual Studio 2013 build numbers

| Date       | Name                        | IDE Version   | Remarks |
| ---------- | --------------------------- | ------------- | ------- |
| 2015-07-20 | Visual Studio 2013 Update 5 |               | [*](https://support.microsoft.com/en-us/kb/3021976) |
| 2014-11-12 | Visual Studio 2013 Update 4 |               | [*](https://support.microsoft.com/en-us/kb/2994375) |
| 2014-08-04 | Visual Studio 2013 Update 3 |               | [*](https://support.microsoft.com/en-us/kb/2933779) |
| 2014-05-12 | Visual Studio 2013 Update 2 |               | [*](https://support.microsoft.com/en-us/kb/2927432) |
| 2014-01-20 | Visual Studio 2013 Update 1 |               | [*](https://support.microsoft.com/en-us/kb/2911573) |
|            | Visual Studio 2013          |               |

# Visual Studio 2010 build numbers

| Name                   | IDE Version   |
| ---------------------- | ------------- |
| Visual Studio 2010 SP1 | 10.0.40219    |
| Visual Studio 2010     | 10.0.30319    |

<https://msdn.microsoft.com/en-us/library/mt695655.aspx>

# C++ Redistributables

| Date       | Name                                | Version        | Remarks |
| ---------- | ----------------------------------- | -------------- | ------- |
|            | Visual C++ 2017                     | 14.10.25008    | |
|            | Visual C++ 2017 RC                  | 14.10.24629    | |
|            | Visual C++ ? (included in TFS 2015 Test VMs) | 14.0.24425     | |
|            | Visual C++ 2017 Preview 4?          | 14.0.24406     | |
| 2016-09-15 | Visual C++ 2015 Update 3 "d"        | 14.0.24215.1   | [*](https://www.microsoft.com/en-us/download/details.aspx?id=53840) |
| 2016-07-20 | Visual C++ 2015 Update 3 "b"        | 14.0.24212     | |
| 2016-06-27 | Visual C++ 2015 Update 3            | 14.0.24210     | |
| 2016-06-02 | Visual C++ 2015 Update 3 RC         | 14.0.24123     | |
| 2016-03-30 | Visual C++ 2015 Update 2            | 14.0.23918     | |
| 2015-11-30 | Visual C++ 2015 Update 1            | 14.0.23506     | |
| 2015-07-20 | Visual C++ 2015                     | 14.0.23026     | |
| 2014-12-30 | Visual C++ 2013 Update 2-5          | 12.0.30501.1   | [*](https://www.microsoft.com/en-us/download/details.aspx?id=40784) |
| 2013-10-05 | Visual C++ 2013                     | 12.0.21005.1   | |
|            | Visual C++ 2012 Update 4            | 11.0.61030     | |
|            | Visual C++ 2012 Update 3            | 11.0.60610     | |
|            | Visual C++ 2012 Update 1            | 11.0.51106     | |
|            | Visual C++ 2012                     | 11.0.50727     | [*](http://stackoverflow.com/questions/18398221/c-redistributable-2012-update-3-detection) |
| 2011-08-09 | Visual C++ 2010 Service Pack 1 SU   | 10.0.40219.325 | Security update MS11-025 |
| 2011-07-27 | Visual C++ 2010 Service Pack 1      | 10.0.40219.1   | |
|            | Visual C++ 2010                     | 10.0.30319.1   | |
| 2011-06-14 | Visual C++ 2008 SP1 Security Update | 9.0.30729.6161 | |
| 2011-06-07 | Visual C++ 2008 SP1 MFC Update      | 9.0.30729.5677 | |
|            | Visual C++ 2008 (included in VS2010) | 9.0.30729.4974 | |
| 2010-09-29 | Visual C++ 2008 SP1 ATL Update      | 9.0.30729.4148 | |
| 2008-09-16 | Visual C++ 2008 SP1                 | 9.0.30729.17   | |
| 2008-08-11 | Visual C++ 2008 SP1 "VS 2008 SP1"   | 9.0.30729.1    | Part of Visual Studio 2008 |
| 2007-11-29 | Visual C++ 2008                     | 9.0.21022.8    | |
|            | Visual C++ 2005 SP1 MFC Update      | 8.0.50727.6195 | Add/Remove Software: 8.0.61001 |
|            | Visual C++ 2005 ?                   | 8.0.50727.4940 | |
| 2009-07-28 | Visual C++ 2005 SP1 ATL Update      | 8.0.50727.4053 | MS09-35 KB973544 KB973923 |
|            | Visual C++ 2005 SP1                 | 8.0.50727.762  | Add/Remove Software: 8.0.56336 |
|            | Visual C++ 2005                     | 8.0.50727.42   | Add/Remove Software: 8.0.50727.42 |

<http://www.tmurgent.com/AppVirt/VCRuntimes.aspx>  

<http://karanpc.com/microsoft-visual-c/>

```
dir "C:\Program Files (x86)\Microsoft Visual Studio" -Recurse -Filter "vcredist*" | Get-FileVersionInfo
```

C++ Compiler version:

```
# Using PowerShell
Get-WmiObject -Class win32_Product | ?{ $_.Name.Contains('Visual C++ Library MFC') } | select 'Name', 'Version' | Group-Object 'Version'
# By starting the compiler
cl.exe
# In C++ 
_MSC_FULL_VER
```

```
# Check versions of installers
PS C:\Tools\VcRedist> dir | Get-FileVersionInfo

ProductVersion   FileVersion      FileName
--------------   -----------      --------
6.00.2900.2180   6.00.2900.218... vcredist_x64 (vc2005).exe
6.00.3790.0      6.00.3790.0 (... vcredist_x64 (vc2005sp1).exe
9.0.21022.08     9.0.21022.08     vcredist_x64 (vc2008).exe
9.0.30729.17     9.0.30729.17     vcredist_x64 (vc2008sp1a).exe
9.0.30729.4148   9.0.30729.4148   vcredist_x64 (vc2008sp1b).exe
9.0.30729.5677   9.0.30729.5677   vcredist_x64 (vc2008sp1c).exe
10.0.30319.01    10.0.30319.01    vcredist_x64 (vc2010).exe
10.0.40219.01    10.0.40219.01    vcredist_x64 (vc2010sp1).exe
10.0.40219.325   10.0.40219.325   vcredist_x64 (vc2010sp1b).exe
12.0.21005.1     12.0.21005.1     vcredist_x64 (vc2013).exe
12.0.30501.0     12.0.30501.0     vcredist_x64 (vc2013b).exe
14.0.24215.1     14.0.24215.1     vcredist_x64 (vc2015).exe
14.0.24215.1     14.0.24215.1     vcredist_x64 (vc2015b).exe
2.0.50727.42     2.0.50727.42     vcredist_x86 (vc2005).exe
2.0.50727.762    2.0.50727.762    vcredist_x86 (vc2005sp1).exe
9.0.21022.08     9.0.21022.08     vcredist_x86 (vc2008).exe
9.0.30729.17     9.0.30729.17     vcredist_x86 (vc2008sp1a).exe
9.0.30729.4148   9.0.30729.4148   vcredist_x86 (vc2008sp1b).exe
9.0.30729.5677   9.0.30729.5677   vcredist_x86 (vc2008sp1c).exe
10.0.30319.01    10.0.30319.01    vcredist_x86 (vc2010).exe
10.0.40219.01    10.0.40219.01    vcredist_x86 (vc2010sp1).exe
10.0.40219.325   10.0.40219.325   vcredist_x86 (vc2010sp1b).exe
12.0.21005.1     12.0.21005.1     vcredist_x86 (vc2013).exe
12.0.30501.0     12.0.30501.0     vcredist_x86 (vc2013b).exe
14.0.24215.1     14.0.24215.1     vcredist_x86 (vc2015).exe
14.0.24215.1     14.0.24215.1     vcredist_x86 (vc2015b).exe
```

# Visual Studio Team Foundation Server build numbers

| Date       | Name                            | IDE Version    |
| ---------- | ------------------------------- | -------------- |
| 2017-03-09 | TFS 2017 Update 1 b             | 15.112.26307.0 |
| 2017-03-07 | TFS 2017 Update 1               | 15.112.26301.0 |
|            | TFS 2017 Update 1 RC2           | 15.112.26206.0 |
|            | TFS 2017 Update 1 RC1           | 15.111.26117.0 |
|            | TFS 2017                        | 15.105.25910.0 |
|            | TFS 2017 RC2                    | 15.105.25716.0 |
|            | TFS 2017 RC1                    | 15.103.25603.0 |
|            | TFS 2015 Update 4 RC1           | 14.113.26306.0 |
|            | TFS 2015 Update 3               | 14.102.25423.0 |
|            | TFS 2015 Update 2.1             | 14.95.25229.0  |
|            | TFS 2015 Update 2               | 14.95.25122.0  |
|            | TFS 2015 Update 2 RC2           | 14.95.25029.0  |
|            | TFS 2015 Update 2 RC1           | 14.95.25005.0  |
|            | TFS 2015 Update 1               | 14.0.24712.0   |
|            | TFS 2015 Update 1 RC2           | 14.0.24626.0   |
|            | TFS 2015 Update 1 RC1           | 14.0.24606.0   |
|            | TFS 2015                        | 14.0.23128.0   |
|            | TFS 2015 RC2                    | 14.0.23102.0   |
|            | TFS 2015 RC1                    | 14.0.22824.0   |
|            | TFS 2015 CTP                    | 14.0.22604.0   |
|            | TFS 2013 Update 5               | 12.0.40629.0   |
|            | TFS 2013 Update 4               | 12.0.31101.0   |
|            | TFS 2013 Update 4 RC            | 12.0.31010.0   |
|            | TFS 2013 Update 3               | 12.0.30723.0   |
|            | TFS 2013 Update 3 RC            | 12.0.30626.0   |
|            | TFS 2013 Update 2               | 12.0.30324.0   |
|            | TFS 2013 Update 1               | (non-existing) |
|            | TFS 2013                        | 12.0.21005.1   |
|            | TFS 2013 RC                     | 12.0.20827.3   |
|            | TFS 2012 Update 4               | 11.0.61030.0   |
|            | TFS 2012 Update 3               | 11.0.60610.1   |
|            | TFS 2012 Update 2               | 11.0.60315.1   |
|            | TFS 2012 Update 1 CU1           | 11.0.60123.100 |
|            | TFS 2012 Update 1               | 11.0.51106.1   |
|            | TFS 2012                        | 11.0.50727.1   |
|            | TFS 2010 CU2                    | 10.0.40219.371 |
|            | TFS 2010 SP1                    | 10.0.40219.1   |
|            | TFS 2010                        | 10.0.30319.1   |
|            | TFS 2008 SP1                    | 9.0.30729.1    |
|            | TFS 2008                        | 9.0.21022.8    |
|            | TFS 2005 SP1                    | 8.0.50727.762  |
|            | TFS 2005                        | 8.0.50727.147  |

<https://blogs.msdn.microsoft.com/tfssetup/2013/11/21/what-version-of-team-foundation-server-do-i-have/>
