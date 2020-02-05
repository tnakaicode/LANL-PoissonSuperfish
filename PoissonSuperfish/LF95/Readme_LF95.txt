This directory contains sample source files and batch files for 
building LF95 main programs that use the Poisson Superfish field
interpolator. One method calls a DLL generated with LF95. The other 
method uses LF95 subroutines in a Fortran 95 Library.


Refer to section II. F. in file SFintro.doc for information about the 
DLL function calling parameters and for a description of the example
source files. 


Files in this directory related to using the DLL:

fld_lf95.dll      Dynamic link library
fld_lf95.obj      Object module used to create the DLL
fld_lf95.lib      Microsoft-compatible import library
Sample_DLL.f90    Fortran 90/95 example source file 
RunLF95_DLL.bat   Batch file that compiles and runs Sample_DLL.f90


Files in this directory related to using the Fortran library:

LANLSF.Lib	Fortran library containing the field interpolator
Sample.F90	Source file using the interpolator on a Poisson problem
Sample2.F90	Source file using the interpolator on a CFish problem
T35Array.Inc	INCLUDE file used by codes with complex arrays
Modules.F90	Fortran modules used by library routines and sample programs
Resource.Obj	Required object module for linking sample programs
SF_RDT35.F90	Subroutine for reading the binary solution file
SF_RDR1.F90	Subroutine for reading the first record from the solution file
LF95.Fig	Lahey/Fujitsu Fortran 95 configuration file
RunSampl.Bat	Batch file that compiles and runs Sample.f90 and Sample2.f90



If the linker cannot find the libraries mentioned in LF95.fig, add 
path information on -lib lines in that file, or add the path to the
LF95 library directory to the LIB environment variable (e.g. 
LIB=C:\LF9557\Lib).



Interpolating fields from multiple solution files

Subroutine INTERP in the dynamic link library will automatically switch 
between different .T35 solution files whenever the name of the file on 
the calling line changes.  However, switching between files very often 
may cause an application to run very slowly.  To avoid this problem,
an application can keep open up to 4 different solution files if the 
program is linked with additional DLLs provided separately in WinZip 
file MultiDLL.zip on the LAACG FTP servers.  After downloading this
file, extract the following additional files to the LF95 subdirectory:

fld1_LF95.dll, fld2_LF95.dll, fld3_LF95.dll   Dynamic link libraries
fld1_LF95.obj, fld2_LF95.obj, fld3_LF95.obj   Object modules 
fld1_LF95.lib, fld2_LF95.lib, fld3_LF95.lib   Import libraries  

Each DLL contains the same the four functions as fld_LF95.dll, but the 
functions have the number 1, 2, or 3 appended to their names.  For
example, file fld1_LF95.dll contains functions INTERP1, I_Variable1,
R_Variable1, and GetTitle1.



Following are the results of executing the command 
dumpbin /exports fld_lf95.dll

Microsoft (R) COFF Binary File Dumper Version 6.00.8447
Copyright (C) Microsoft Corp 1992-1998. All rights reserved.


Dump of file fld_lf95.dll

File Type: DLL

  Section contains the following exports for fld_lf95.dll

           0 characteristics
    40E423A4 time date stamp Thu Jul 01 08:45:56 2004
        0.00 version
           1 ordinal base
           4 number of functions
           4 number of names

    ordinal hint RVA      name

          1    0 00004760 GETTITLE_
          2    1 00001000 INTERP_
          3    2 000036E0 I_VARIABLE_
          4    3 00004040 R_VARIABLE_

  Summary

      193000 .data
       26000 .rdata
       1A000 .reloc
        9000 .rsrc
      103000 .text
        1000 codeseg
