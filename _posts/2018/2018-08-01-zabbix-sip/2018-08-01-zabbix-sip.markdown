---
title: "Zabbix SIP server monitoring"
tags: [zabbix, sip, voip]
image: zabbix.png
---

Zabbix can be used to monitor availability and up-time of a SIP server or phone.

<!--more-->

A template can be found on GitHub: [Link](https://github.com/WimObiwan/ZabbixCustomTemplates/tree/master/SIP)

* The template uses an external script to run the check.  You need to put the contents of the *externalscripts* subfolder under your Zabbix external scripts folder (on my Zabbix installation on Debian, this is `/usr/lib/zabbix/externalscripts/`) 
* Import the template in the Zabbix user interface:
  * Go to *Configuration*, *Templates*
  * In the top-right corner, click on *Import*
  * Select the template XML file and click *Import* 
