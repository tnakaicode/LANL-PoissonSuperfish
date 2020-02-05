This directory (CVF) contains a sample source file for Compaq Visual 
Fortran that calls a DLL generated with LF95.  The code uses the 
same DLL found in directory MSVC for the Microsoft Visual C language
system.  Files in this directory have been renamed.       

The example was provided by Tibor Kibedi (Tibor.Kibedi@anu.edu.au),
Department of Nuclear Physics, Australian National University,
Canberra, ACT 0200, Australia. 

The compiler used to develop this example was Compaq (Intel) Visual 
Fortran v6.6b.  The CVF compiler changed its name to Intel Fortran 
Compiler sometime in late 2003 or early 2004.  Please let us know if 
you have any experience using the CVF DLL with newer versions of the 
Intel Fortran Compiler.


Refer to section II. F. in file SFintro.doc for information about the 
DLL function calling parameters. 


Files in this directory:

fld_CVF.dll       Dynamic link library
fld_CVF.obj       Object module used to create the DLL
fld_CVF.lib       Microsoft-compatible import library  
CVFInterp1.f90    Compaq Visual Fortran example source file 


In this example, the name of the Poisson Superfish solution file is 
defined in the code as HTEST1.T35.  To create HTEST.T35, run the 
examples in directory LANL\Examples\Magnetostatic\H-Magnet.  You may
wish to add code to enter other filenames.  The program requests X 
and Y coordinates and writes the solution, field components, and 
derivatives to file OUT.TXT. 

File CVFInterp1.f90 contains compiler directives that allow compilation 
to proceed with all default compiler settings. 




Interpolating fields from multiple solution files

Subroutine INTERP in the dynamic link library will automatically switch 
between different .T35 solution files whenever the name of the file on 
the calling line changes.  However, switching between files very often 
may cause an application to run very slowly.  To avoid this problem,
an application can keep open up to 4 different solution files if the 
program is linked with additional DLLs provided separately in WinZip 
file MultiDLL.zip on the LAACG FTP servers.  After downloading this
file, extract the following additional files to the CVF subdirectory:

fld1_CVF.dll, fld2_CVF.dll, fld3_CVF.dll   Dynamic link libraries
fld1_CVF.obj, fld2_CVF.obj, fld3_CVF.obj   Object modules 
fld1_CVF.lib, fld2_CVF.lib, fld3_CVF.lib   Import libraries  

Each DLL contains the same the four functions as fld_CVF.dll, but the 
functions have the number 1, 2, or 3 appended to their names.  For
example, file fld1_CVF.dll contains functions INTERP1, I_Variable1,
R_Variable1, and GetTitle1. 

The WinZip file MultiDLL.zip contains Compaq Visual Fortran source 
file CVFInterp4.f90 (also supplied by Tibor Kibedi).  The program
demonstrates using 4 DLLs simultaneously.


 



Following are the results of executing the command 
dumpbin /exports fld_cvf.dll


Microsoft (R) COFF Binary File Dumper Version 6.00.8447
Copyright (C) Microsoft Corp 1992-1998. All rights reserved.


Dump of file fld_cvf.dll

File Type: DLL

  Section contains the following exports for fld_cvf.dll

           0 characteristics
    40E423AD time date stamp Thu Jul 01 08:46:05 2004
        0.00 version
           1 ordinal base
           4 number of functions
           4 number of names

    ordinal hint RVA      name

          1    0 00004770 _GETTITLE@4
          2    1 00001000 _INTERP@36
          3    2 000036F0 _I_VARIABLE@4
          4    3 00004050 _R_VARIABLE@4

  Summary

      193000 .data
       26000 .rdata
       1A000 .reloc
        9000 .rsrc
      103000 .text
        1000 codeseg
