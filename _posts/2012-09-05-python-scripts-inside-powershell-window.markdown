---
title: "Python scripts inside PowerShell window"
tags: [python, powershell]
image: /assets/2012-09-05-python-scripts-in-powershell-0.png
---

Python scripts can be run seamlessly in a Powershell console window.

<!--more-->

After installing Python on Windows, you can start a Python script by executing the script file-name.  
For example:

```bash
./MyScript.py
```

However, the command is not executed in the same PowerShell window. It opens a **new** command window 
to start `python.exe`, which executes the command (and immediately closes the window).

This behavior can be changed, and the script can be executed within the current PowerShell window.
Just add the `.py` file extension to the `PATHEXT` environment variable. This can be done by executing 
this command:

```bash
$env:PATHEXT += ";.py"
```

You can add this command to your `$profile` file, so you don't need to execute this command in every 
newly started PowerShell window. Run the next command to add this line to your `$profile` automatically:

```bash
"`n" + '$env:PATHEXT += ";.py" # Transparent execution of Python scripts' |Out-File $profile -Append -Encoding Default
```

You can test it by creating and running a small script:

```bash
'print("Hello, World!")' | Out-File MyScript.py -Encoding Default
.\MyScript.py
```

![Screenshot](/assets/2012-09-05-python-scripts-in-powershell.png)
