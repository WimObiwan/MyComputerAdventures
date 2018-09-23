---
title:  "Getting started with VS Code using C# and .NET Core on Ubuntu"
tags: [c#, visualstudio, ubuntu]
image: vs2015.png
---

A tutorial on how to compile and run C# application on Ubuntu with Visual Studio Code and .NET Core.

<!--more-->

<iframe src="https://channel9.msdn.com/Blogs/dotnet/Get-started-with-VS-Code-Csharp-dotnet-Core-Ubuntu/player" width="800" height="450" allowFullScreen frameBorder="0"></iframe>

Steps:

* Download & install Visual Studio Code from [this link](https://code.visualstudio.com/download).  
  For Ubuntu, download the DEB file and install by double clicking on it.

* Enable the C# plugin
  * Ctrl-Shift-X
  * Search for C# (provider Microsoft)
  * Enable the plugin and restart Visual Studio Code.

* Install .NET Core (as documented on [this link](https://www.microsoft.com/net/core#ubuntu))

  ```
  # For Ubuntu 16.04, but also works on Ubuntu 16.10.
  sudo sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list'
  sudo apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893
  sudo apt-get update
  sudo apt-get install dotnet-dev-1.0.0-preview2-003131
  ```