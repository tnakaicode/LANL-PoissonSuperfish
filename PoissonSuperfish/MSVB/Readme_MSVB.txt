If we receive any samples from Poisson Superfish users of a 
Microsoft Visual Basic main program that calls a DLL generated 
with LF95, we will include them in this directory.

Refer to section II. F. in file SFintro.doc for information about 
the DLL function calling parameters. 


Files in this directory:

fld_msvb.dll       Dynamic link library
fld_msvb.obj       Object module used to create the DLL
fld_msvb.lib       Microsoft-compatible import library  


If you develop an example Microsoft Visual Basic main program file 
that performs the same task as the LF95 programs Sample.F90 and 
Sample_DLL.F90, please send an example source file and batch file 
by email to Superfish@lanl.gov. We will add your example to the 
code distribution with an acknowledgment in your example files, 
this file, and in the documentation. (Please let us know if you 
do not wish such an cknowledgment. Likewise, let us know if you 
would be willing to answer questions from other code users.)




Interpolating fields from multiple solution files

Subroutine INTERP in the dynamic link library will automatically switch 
between different .T35 solution files whenever the name of the file on 
the calling line changes.  However, switching between files very often 
may cause an application to run very slowly.  To avoid this problem,
an application can keep open up to 4 different solution files if the 
program is linked with additional DLLs provided separately in WinZip 
file MultiDLL.zip on the LAACG FTP servers.  After downloading this
file, extract the following additional files to the msvb subdirectory:

fld1_msvb.dll, fld2_msvb.dll, fld3_msvb.dll   Dynamic link libraries
fld1_msvb.obj, fld2_msvb.obj, fld3_msvb.obj   Object modules 
fld1_msvb.lib, fld2_msvb.lib, fld3_msvb.lib   Import libraries  

Each DLL contains the same the four functions as fld_msvb.dll, but the 
functions have the number 1, 2, or 3 appended to their names.  For
example, file fld1_msvb.dll contains functions INTERP1, I_Variable1,
R_Variable1, and GetTitle1.



Following are the results of executing the command 
dumpbin /exports fld_msvb.dll


Microsoft (R) COFF Binary File Dumper Version 6.00.8447
Copyright (C) Microsoft Corp 1992-1998. All rights reserved.


Dump of file fld_msvb.dll

File Type: DLL

  Section contains the following exports for fld_msvb.dll

           0 characteristics
    40E423AB time date stamp Thu Jul 01 08:46:03 2004
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
