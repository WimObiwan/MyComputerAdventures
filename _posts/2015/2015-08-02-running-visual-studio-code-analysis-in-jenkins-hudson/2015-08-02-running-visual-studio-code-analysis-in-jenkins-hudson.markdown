---
title: "Running Visual Studio code analysis in Jenkins/Hudson"
tags: [visualstudio, jenkins, hudson]
image: running-visual-studio-code-analysis-0.png
---

Code analysis can be extremely useful to detect certain errors that are difficult to find.  Enabling it on you Jenkins/Hudson is very easy.

<!--more-->

A very common crash in C++ code, is an error in the `printf` *format specifier*, e.g.

{% highlight cpp %}
int iValue = 17; 
printf("%s", iValue);
{% endhighlight %}

This code compiles perfectly, but will crash when executing, because memory on address 17 will be read.  
Code analysis can assist in detecting these and lots of other errors, which are otherwise difficult 
to find.  Other languages like C# have similar code analysis.

![VisualStudio Code Analysis](running-visual-studio-code-analysis-1.png)

Since code analysis takes a long time, it is a good example of something that could be off-loaded to the build server, 
e.g. every night.

First make sure that the PowerShell plugin is installed on your Jenkins server.

Next, create a new project, add a **Powershell** *build step*, and paste this script: 

{% highlight powershell %}
$sln='.\MySolution.sln'    # path based on the workspace root
$configuration='/p:Configuration=Release'
$platform='/p:Platform="Win32"'

#only take these warnings into account
$severe_warnings_list = @(
    4789 #: Destination of memory copy is too small
    6053 #: Call to function may not zero-terminate string
    6057 #: Buffer overrun due to number of characters/bytes mismatch
    6059 #: Incorrect length parameter
    6063 #: Missing string argument
    6064 #: Missing integer argument
    6066 #: Non-pointer passed as parameter when pointer is required
    6067 #: Parameter in call must be the address of the string
    6066 #: Non-pointer passed as parameter when pointer is required
    6209 #: Using sizeof when a character count might be needed.
    6269 #: Possible incorrect order of operations: dereference ignored
    6270 #: Missing float argument to varargs function
    6271 #: Extra argument: parameter not used by the format string
    6272 #: Non-float passed as argument  when float is required
    6273 #: Non-integer passed as a parameter when integer is required
    6278 #: array new [] paired with scalar delete
    6281 #: relational/bitwise operator precedence problem
    6282 #: Incorrect operator: assignment of constant in Boolean context
    6283 #: array new [] paired with scalar delete
    6284 #: Object passed as a parameter when string is required
    6290 #: Bitwise operation on logical result: precedence error
    6302 #: Format string mismatch: char* when wchar_t* needed
    6303 #: Format string mismatch:  wchar_t* when char* needed
    6306 #: Incorrect call to 'fprintf*': consider using 'vfprintf*'
    6328 #: Wrong parameter type passed
    6334 #: Sizeof operator applied to an expression with an operator
    6336 #: Arithmetic/question operator precedence problem
    6522 #: Invalid size specification: expression must be of integral type
    6523 #: "Invalid size specification: parameter 'size' not found
)

$a = $(. "C:\PROGRA~2\MSBuild\12.0\Bin\MSBuild.exe" $configuration $platform 
        /p:RunCodeAnalysis=true $sln)

# Take out certain link and BSC compiler warnings
$b = $a | where { $_.Contains('warning') -and $_ -match '^  ' `
    -and $_ -notmatch 'warning LNK' -and $_ -notmatch 'warning BK' }
# Take out 3rd-party libraries
$b = $b | where { ($_ -replace ('^\s*' + [regex]::Escape($env:WORKSPACE) `
    + '(.*?)\(\d+\)\: .*$'), '$1') 
        -notmatch '^\\libraries\\(?:boost|x(?:un)?zip\.cpp|xmlite\.cpp)' }
# Only keep warnings from the severe_warnings_list
$severe = @($b | where { ($_ -replace '^.*\: warning C(\d+)\:.*$', '$1') 
    -in $severe_warnings_list })

# Show the warnings
$severe

if ($severe.Length -gt 0) { 
    Write-Warning "Found $($severe.Length) severe code analysis warnings!"
    exit 1
} else {
    ($b -replace '^.*\: warning (C\d+)\:.*$', '$1') | group | sort -Descending Count
}

exit 0
{% endhighlight %}
