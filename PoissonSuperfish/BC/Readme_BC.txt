This directory contains a sample source file and batch file that 
builds a Borland C main program that calls a DLL generated with LF95. 

The C source file was developed by Harunori Takeda of Los Alamos
National Laboratory using Borland C++ version 5.2.  

Refer to section II. F. in file SFintro.doc for information about the 
DLL function calling parameters. 


Files in this directory:

fld_bc.dll       Dynamic link library
fld_bc.obj       Object module used to create the DLL
fld_bc.lib       Microsoft-compatible import library  
Sample_DLL.c     Borland C example source file 
RunBC_DLL.bat    Batch file that compiles and runs Sample_DLL.c


The batch file will regenerate an import library that is compatible 
with the Borland C language system.



Interpolating fields from multiple solution files

Subroutine INTERP in the dynamic link library will automatically switch 
between different .T35 solution files whenever the name of the file on 
the calling line changes.  However, switching between files very often 
may cause an application to run very slowly.  To avoid this problem,
an application can keep open up to 4 different solution files if the 
program is linked with additional DLLs provided separately in WinZip 
file MultiDLL.zip on the LAACG FTP servers.  After downloading this
file, extract the following additional files to the BC subdirectory:

fld1_BC.dll, fld2_BC.dll, fld3_BC.dll   Dynamic link libraries
fld1_BC.obj, fld2_BC.obj, fld3_BC.obj   Object modules 
fld1_BC.lib, fld2_BC.lib, fld3_BC.lib   Import libraries  

Each DLL contains the same the four functions as fld_BC.dll, but the 
functions have the number 1, 2, or 3 appended to their names.  For
example, file fld1_BC.dll contains functions INTERP1, I_Variable1,
R_Variable1, and GetTitle1.



Following are the results of executing the command 
dumpbin /exports fld_bc.dll

Microsoft (R) COFF Binary File Dumper Version 6.00.8447
Copyright (C) Microsoft Corp 1992-1998. All rights reserved.


Dump of file fld_bc.dll

File Type: DLL

  Section contains the following exports for fld_bc.dll

           0 characteristics
    40E423A9 time date stamp Thu Jul 01 08:46:01 2004
        0.00 version
           1 ordinal base
           4 number of functions
           4 number of names

    ordinal hint RVA      name

          1    0 00004770 GETTITLE
          2    1 00001000 INTERP
          3    2 000036F0 I_VARIABLE
          4    3 00004050 R_VARIABLE

  Summary

      193000 .data
       26000 .rdata
       1A000 .reloc
        9000 .rsrc
      103000 .text
        1000 codeseg
