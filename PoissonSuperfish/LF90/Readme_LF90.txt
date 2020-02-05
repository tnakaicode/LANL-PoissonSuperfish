This directory contains a sample source file and batch file that
builds a LF90 main program that calls a DLL generated with LF95. 

Refer to section II. F. in file SFintro.doc for information about the 
DLL function calling parameters. 


Files in this directory:

fld_lf90.dll      Dynamic link library
fld_lf90.obj      Object module used to create the DLL
fld_lf90.imp      Linker commands needed to link main program with the DLL 
Sample_DLL.f90    Fortran 90 example source file 
RunLF90_DLL.bat   Batch file that compiles and runs Sample_DLL.f90
lf90.fig          Lahey Fortran 90 configuration file



If the linker cannot find the libraries mentioned in LF90.fig, check 
to be sure the path information on -mod and -lib lines in LF90.fig
is correct. 




Interpolating fields from multiple solution files

Subroutine INTERP in the dynamic link library will automatically switch 
between different .T35 solution files whenever the name of the file on 
the calling line changes.  However, switching between files very often 
may cause an application to run very slowly.  To avoid this problem,
an application can keep open up to 4 different solution files if the 
program is linked with additional DLLs provided separately in WinZip 
file MultiDLL.zip on the LAACG FTP servers.  After downloading this
file, extract the following additional files to the LF90 subdirectory:

fld1_LF90.dll, fld2_LF90.dll, fld3_LF90.dll   Dynamic link libraries
fld1_LF90.obj, fld2_LF90.obj, fld3_LF90.obj   Object modules 
fld1_LF90.lib, fld2_LF90.lib, fld3_LF90.lib   Import libraries  

Each DLL contains the same the four functions as fld_LF90.dll, but the 
functions have the number 1, 2, or 3 appended to their names.  For
example, file fld1_LF90.dll contains functions INTERP1, I_Variable1,
R_Variable1, and GetTitle1.




Following are the results of executing the command 
dumpbin /exports fld_lf90.dll


Microsoft (R) COFF Binary File Dumper Version 6.00.8447
Copyright (C) Microsoft Corp 1992-1998. All rights reserved.


Dump of file fld_lf90.dll

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
