---
title: "Removing macro's from a LibreOffice/OpenOffice document"
tags: [libreoffice/openoffice]
image: /assets/2012-01-09-libreoffice.png
---

This procedure explains a way to remove macros from a LibreOffice/OpenOffice
document.

<!--more-->

Sometimes for some reason I don't know yet, an empty macro is added to an 
existing OpenDocument Spreadsheet (`ods`) document.  When opening the document,
you get the security warning `This document contains macros. Execution of this 
macros is disabled due to the current macro security setting. Therefore, some 
functionality may not be available.`  The document was originally created in 
*[Lotus Symphony for DOS](https://en.wikipedia.org/wiki/Lotus_Symphony_%28DOS%29)*, 
later imported to *Microsoft Excel*, and currently converted to 
*LiberOffice/OpenOffice* *OpenDocument Spreadsheet* (`ods`) document.  But I 
guess the history of the document has nothing to do with it.

Since I didn't need macro's, I wanted to delete them.
I investigated them using:

* menu `Tools`
* menu-item `Organize Macros`
* `LibreOffice Basic`

A `Basic` macro was present, but only contained whitespace. For some reason, 
I was unable to remove the macro because the button `Delete` was disabled.

A workaround is to remove the macros programmatically: yes, *with another 
macro*...

In the window `LibreOffice Basic Macros`, click the button `Edit` 
and add the code below:

```vb
Sub RemoveMacros
   basicLibraries = ThisComponent.BasicLibraries
   standard = basicLibraries.getByName( "Standard" )
   standard.removeByName( "Module1" )
End Sub
```

Change the text `Module1` to the name of the Module that you want to delete. 
Run the code by pressing the key `F5`.  You can ignore the error about removing
yourself. This code works on both *LibreOffice* and *OpenOffice*.  

**UPDATE 2016-03-21:** The macros have come back a few times since then, but
the same workaround still works.  I still have no idea how the macros are 
re-added automatically(?) to the spreadsheet...