---
title: "Headless Ubuntu (Server) distribution upgrade"
tags: [linux]
image: /assets/2012-10-28-ubuntu.png
---

Information about how to upgrade Ubuntu from the command line.

<!--more-->

Doing a distribution upgrade is easy in the graphical user interface. 
On a "headless" Ubuntu Server, you probably don't have a graphical user interface available, and you need to perform a few easy steps.

First you need to check 2 things:

* The package `update-manager-core` needs to be installed.
  Just run the following command: (it will install it, if it is not already)

    {: .language-bash}
      sudo apt-get install update-manager-core

 * On *Ubuntu Server*, the update channel is usually ***"LTS"*** (Long Time Support) which will upgrade only to the major release of Ubuntu Server.
   Probably, you want to set this to ***"normal"***, to allow an upgrade to every distribution upgrade.
   
   To do this, open the file `/etc/update-manager/release-upgrades`, and change the line `Prompt=lts` to `Prompt=normal`.
   
   For example, with `nano`:

    {: .language-bash}
      sudo pico /etc/update-manager/release-upgrades
   
   Change the Prompt setting to "normal". Press `Ctrl-X`, press `Y` to confirm and press enter to confirm the filename.
  
Then the distribution upgrade can be started by running this command:

  {: .language-bash}
    sudo do-release-upgrade -d

It is *not recommended* to do a distribution upgrade remotely over `ssh`. The `do-release-upgrade` command above checks on this, and gives a warning. However, I didn't have any problem doing the upgrade remotely over ssh.
