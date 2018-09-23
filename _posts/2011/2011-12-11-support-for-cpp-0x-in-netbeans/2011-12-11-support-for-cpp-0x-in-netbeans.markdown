---
title: "Support for C++0x / C++11 in NetBeans"
tags: [c++, netbeans]
image: support-for-c++11-in-netbeans-0.png
---

Manually enabling C++0x / C++11 in NetBeans.

<!--more-->

C++0x / C++11 is not officially supported by NetBeans.  However, most features of the new C++ standard can be used after enabling it in the project options:

 * open the Project Options, 
 * select the category "C++ Compiler" under "Build", 
 * add `-std=c++0x` to the Additional Options of the Command Line. If you want to keep the GNU extensions, then you should add `-std=gnu++0x` instead.

![screenshot](support-for-c++11-in-netbeans.png)

This adds support for the latest C++ standard when invoking the g++ compiler.  To add support for C++0x / C++11 in the IDE, you need to:

 * open the Options in the Tool menu,
 * select the C/C++ icon
 * select the tab "Code Assistance"
 * select the sub-tab "C++"
 * add `__GXX_EXPERIMENTAL_CXX0X__`

According to the NetBeans release notes, version 7.1 will have partial support for C++0x / C++11 (e.g. support for the auto keyword).
Be aware that no compiler/IDE has complete support for C++0x / C++11 yet.
For a list of new features in C++11, you can read this very readable document of the C++ inventor Bjarne Stroustrup: [C++11 FAQ](http://www2.research.att.com/~bs/C++0xFAQ.html). 
