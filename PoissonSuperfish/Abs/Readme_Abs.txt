This file describes how to build an Absoft Fortran 8.0 main program 
that calls a DLL generated with LF95. 

Refer to section II. F. in file SFintro.doc for information about the 
DLL function calling parameters. 


Files in this directory:

fld_Abs.dll        Dynamic link library
fld_Abs.def        Definition file for use with Absoft imptool
fld_Abs.lib        Absoft-compatible import library  
sample_abs.f90     Fortran 90 example source file 
sample_abs.gui     Launches the Absoft Developer Tools interface program 
RunAbs_DLL.bat     Batch file that compiles and runs Sample_Abs.f90


The import library fld_lf90.lib was created using the Absoft tool imptool 
from definition file fld_lf90.def as follows:  

imptool -def:fld_abs.def -out:fld_abs.lib


The batch file should work as distributed if you run it from the 
the Absoft Fortran Development Command Shell.  Launch the Development 
Command Shell, navigate to this directory, and type command Run_Abs.Bat.

You may also double click on the file sample_abs.gui to run the Absoft 
Developer Tools, and build the code. Specify the program sample_abs.f90 
and the library file fld_abs.lib

The DLL file used here is the same as the DLL generated for LF90 (i.e.,
file fld_lf90.dll). This procedure does not work with file fld_lf95.dll 
created for LF95.



Interpolating fields from multiple solution files

Subroutine INTERP in the dynamic link library will automatically switch 
between different .T35 solution files whenever the name of the file on 
the calling line changes.  However, switching between files very often 
may cause an application to run very slowly.  To avoid this problem,
an application can keep open up to 4 different solution files if the 
program is linked with additional DLLs provided separately in WinZip 
file MultiDLL.zip on the LAACG FTP servers.  After downloading this
file, extract the following additional files to the Abs subdirectory:

fld1_Abs.dll, fld2_Abs.dll, fld3_Abs.dll   Dynamic link libraries
fld1_Abs.def, fld2_Abs.def, fld3_Abs.def   Definition files

Each DLL contains the same the four functions as fld_Abs.dll, but the 
functions have the number 1, 2, or 3 appended to their names.  For
example, file fld1_Abs.dll contains functions INTERP1, I_Variable1,
R_Variable1, and GetTitle1.

In order to use the numbered DLLs, you must create additional import 
libraries using the Absoft tool imptool.  For example, in order to 
use fld1_Abs.dll, run imptool as follows:

imptool -def:fld1_abs.def -out:fld1_abs.lib



 
Following are the results of executing the command 
dumpbin /exports fld_abs.dll

Microsoft (R) COFF Binary File Dumper Version 6.00.8447
Copyright (C) Microsoft Corp 1992-1998. All rights reserved.


Dump of file fld_abs.dll

File Type: DLL

  Section contains the following exports for fld_lf90.dll

           0 characteristics
    40E423A7 time date stamp Thu Jul 01 08:45:59 2004
        0.00 version
           1 ordinal base
           4 number of functions
           4 number of names

    ordinal hint RVA      name

          1    0 00004760 GETTITLE
          2    1 00001000 INTERP
          3    2 000036E0 I_VARIABLE
          4    3 00004040 R_VARIABLE

  Summary

      193000 .data
       26000 .rdata
       1A000 .reloc
        9000 .rsrc
      103000 .text
        1000 codeseg
