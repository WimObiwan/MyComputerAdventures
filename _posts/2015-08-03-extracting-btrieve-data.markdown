---
title:  "Extracting data from BTrieve files"
tags: [btrieve, c++, powershell]
image: /assets/2015-08-03-extracting-data-from-btrieve-0.png
---

Some guidelines to extract data from BTrieve files using PowerShell.

<!--more-->

The procedure below works with *BTrieve 6.15* and *BTrieve 7* but probably works with older and more recent releases of BTrieve.
Even for *PervasiveSQL* deployments that - for legacy reasons - use BTrieve as their backend, it should work.
But in the latter case, you could (and should) use the new SQL interface (ODBC connector).

1. First, you need to extract the binary information from the BTrieve file.

    * First you need to download this tool:  
     [Download BTrieveFileSaver.zip](/assets/BTrieveFileSaver.zip)
    * Run:
   
          BtrieveFileSaver.exe -btrin MYTABLE.BTV -btrout c:\temp\MyTable.txt

2. The BTrieve file only contains the *data*, and no information about the *model*.

    * When you have the source, that reads or writes the data, then you can extract the model.  
        e.g.: 

                         typedef struct _MyRecord  
          OFF   LEN      {  
            4     4        long  id;  
            8    32        char  name[32];  
          (40)           } MyRecord;

    * The lengths are derived from the datatypes (*C++* in this case). The cumulative lenths are determine the offset of each field. 
      For some reason, there is an initial offset of 4 bytes.
    * If you don't have the source code, you can possibly "reverse engineer" the data from the table.

3. Using a PowerShell script, you can extract, filter and format the data. In this case, we extract the `id` and `name` fields of all records, and show them as a table.

    * A helper function to make it easier to parse the strings

        {: .language-bash}
          Add-Type -AssemblyName 'System.Text.Encoding'
 
          function GetString([byte[]] $buffer, [int] $start, [int] $maxlen) {
            $i = $start
            for ($i = $start; ($i -lt $buffer.Length) -and ($i -lt ($start + $maxlen)); $i++) {
              if ($buffer[$i] -eq 0) {
                break
              }
            }

            $len = $i - $start
            [System.Text.Encoding]::ASCII.GetString($buffer, $start, $len)
          }

    * The actual extraction is simple:

        {: .language-bash}
          $lines = Get-Content c:\temp\MyTable.txt
          $table = $lines | foreach {
            $line = $_
 
            $id = [bitconverter]::ToInt32($line, 16)
            $name = GetString $line 26 48
 
            $obj = New-Object psobject
            $obj | Add-Member -MemberType NoteProperty -Name 'id' -Value $id
            $obj | Add-Member -MemberType NoteProperty -Name 'name' -Value $name
            $obj
          }
 
          $table | Where-Object { $_.name-ne '' } | Sort-Object id | Format-Table -AutoSize
