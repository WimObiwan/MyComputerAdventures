---
title: "Loading .net 4.0 assemblies in PowerShell 2.0"
tags: [powershell]
image: /assets/2011-11-21-powershell.png
---

This post is about changing the configuration of a managed application to 
load the correct *.net framework*.

<!--more-->

.Net assemblies can be load using the command:

```bash
Add-Type -Path ./MyDotNetAssembly.dll
```

The last versions of *Visual Studio* build .net assemblies for *.Net Framework* 
version 4.0 or higher.  By default, PowerShell uses the .Net Framework version 
2.0 run-time, and then you get the following error message in PowerShell: 

```
Add-Type : Could not load file or assembly 'file:///C:\...\MyDotNetAssembly.dll' or one of its dependencies. This assembly is built by a runtime newer than the currently loaded runtime and cannot be loaded. 
At line:1 char:13
+ Add-Type -Path .\MyDotNetAssembly.dll
+                ~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : WriteError: (:) [Add-Type], BadImageFormatException
    + FullyQualifiedErrorId : System.BadImageFormatException,Microsoft.PowerShell.Commands.AddTypeCommand
```

To resolve this problem you can change the config file of PowerShell to let it 
load the *.Net Framework version 4.0* instead of *version 2.0*. This can be 
done using the `PowerShell.exe.config` file.  Locate the program 
`PowerShell.exe` which is typically 
`C:\windows\System32\WindowsPowerShell\v1.0`, and create/update the file 
`PowerShell.exe.config` beside it, with this configuration:

```xml
<?xml version="1.0">
<configuration>
  <startup useLegacyV2RuntimeActivationPolicy="true">
    <supportedRuntime version="v4.0.30319"/>
    <supportedRuntime version="v2.0.50727"/>
  </startup>
</configuration>
```

On *64-bit* machines, the location of 64-bit of *PowerShell* is the same, but 
the *32-bit* version of PowerShell is located under 
`C:\windows\SysWOW64\WindowsPowerShell\v1.0`. 
When you use the 32-bit version of PowerShell, you should create/change the 
config file there too.

The same trick can be applied to other software that hosts PowerShell, such as 
`PowerShell_ISE.exe`.  All you need is create a `application.exe.config` 
configuration file beside `application.exe`.
