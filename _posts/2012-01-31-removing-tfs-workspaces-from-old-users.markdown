---
title: "Removing TFS workspaces from old users or old computers"
tags: [tfs]
image: /assets/2012-01-31-removing-tfs-workspaces.png
---

When working with *Microsoft Team Foundation Server*, sometimes it can be
necessary to cleanup old workspaces. 

<!--more-->

For example, when a computername is re-used, and the same local directory is
used by the new user to map a TFS folder.

You need the tool tfs.exe, which is installed together with Visual Studio. The
easiest way is to start a Visual Studio Command Prompt (search using the
Windows start menu).

I tested the procedure below on Visual Studio 2008 and Visual Studio 2010, but
the procedure should be version-agnostic.

In the commands below, replace serveraddress with your TFS http or https
address, e.g. `https://tfs.mycompany.com:8443`. You can find it in Visual
Studio: 
* menu *Team*
* menu-item *Connect to Team Foundation Server...*
* button *Servers...*

The existing workspaces for some "computername" can be queried with this TFS
command:

In the Visual Studio command prompt, start Powershell:

```bash
powershell.exe
```

This Powershell session inherites the path (and other) environment variables to
the correct Visual Studion installation.

```bash
# update the next line with the correct TFS server
$serveraddress = 'https://tfs.mycompany.com:8443'
tf.exe workspaces "/computer:$($env:COMPUTERNAME)" /owner:* /format:detailed "/server:$serveraddress"
```

You get a list of all workspaces, with the existing mappings. It is the 
workspace name (behind "Workspace:") and the owner that you need in order to 
delete the workspace.

Now run this TFS command in the same powershell session, to remove the 
workspace "workspacename" for owner "owner":

```bash
$workspacename = 'workspacename'
$owner = 'owner'
tf.exe workspace /delete "$($workspacename);$($owner)" /server:$serveraddress
```

Be aware that the *workspacename* and the *computername* are often the same, 
but can be different. On my machine, the first *workspacename* was the same as 
the computername, the next workspaces were suffixed with _0, _1, ...
