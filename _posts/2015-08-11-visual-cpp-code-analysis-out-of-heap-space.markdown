---
title:  "Visual C++ Code Analysis fatal error 'Compiler is out of heap space'"
tags: [c++, visualstudio, windows]
image: /assets/2015-08-11-visual-cpp-code-analysis-out-of-heap-space-0.png
---

When running Visual C++ code analysis (in the *Visual Studio IDE* or *command line*) on a big project, you can get this fatal error: `C1060 compiler is out of heap space`. 

<!--more-->

E.g.:

```
Running Code Analysis for C/C++...
C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\include\locale(70): fatal error C1060: compiler is out of heap space [C:\YourPath\YourProject.vcxproj]
          C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\include\locale(65) : while compiling class template member function 'size_t std::collate::_Getcat(const std::locale::facet **,const std::locale *)'
          C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\include\xlocale(607) : see reference to function template instantiation 'size_t std::collate::_Getcat(const std::locale::facet **,const std::locale *)' being compiled
          C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\include\locale(140) : see reference to class template instantiation 'std::collate' being compiled
```

On a 64-bit machine, the solution is to run the code analysis from the command line **using the 64-bit version of MSBuild.exe**:

```bash
"C:\Program Files (x86)\MSBuild\12.0\Bin\amd64\MSBuild.exe" /p:Configuration=Release /p:Platform="x64" /p:RunCodeAnalysis=true "C:\YourPath\YourProject.vcxproj"
```

So, use the `msbuild.exe` located in the subdirectory `amd64`.

You need to replace the configuration/platform/project according to your needs.
By default, even when releasing 64-bit executables, the 32-bit version of the compiler is used.
This error was also the reason that certain compilations were hanging on our *Jenkins/Hudson build servers*: after this error, 
the `MSBuild.exe` process never terminated until it was killed (in the *Windows Task Manager*) or aborted (in the *Jenkins Web GUI*).
