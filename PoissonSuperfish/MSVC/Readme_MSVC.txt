
This directory (MSVC) contains a sample source file for the Microsoft 
Visual C language system that calls a DLL generated with LF95.  

The example files were provided by Peter de Castro (decastro@jlab.org), 
Thomas Jefferson National Accelerator Laboratory, Newport News, VA 23606, USA.

The compiler used to develop this example was the Microsoft (R) 
32-bit C/C++ Standard Compiler, Version 12.00.8168.

Refer to section II. F. in file SFintro.doc for information about 
the DLL function calling parameters. 


Files in this directory:

fld_msvc.dll       Dynamic link library
fld_msvc.obj       Object module used to create the DLL
fld_msvc.lib       Microsoft-compatible import library
Sample_A.cpp       Sample source file for "implicit" linking
Sample_B.cpp       Sample source file for "explicit" linking

The "A" example links "implicitly" according to Microsoft, and the 
DLL and its .LIB file must be present at compile time.  This example's 
advantage is that the source code calls the function INTERP itself, 
and the loading of the function is relatively simple. 

The "B" example links "explicitly" and only needs its own code to 
compile.  This example's advantage is that the DLL and its LIB file
need not be present to compile.  A possible disadvantage is that the
source code must deal with pointers and handles instead of a direct 
function call.



To compile and link program Sample_A.cpp or Sample_B.cpp using 
Microsoft C, prepare the response file cpp.rsp containing the 
following line:

/W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /c


Run the compiler as follows:

cl Sample_A.cpp  @cpp.rsp
  ---- or ----
cl Sample_B.cpp  @cpp.rsp


Prepare the following response file link.rsp for the linker:

kernel32.lib user32.lib gdi32.lib 
/SUBSYSTEM:windows /INCREMENTAL:no 
/MACHINE:I386 /OUT:"Sample_DLL.exe"


Run the linker as follows:

link Sample_A.OBJ fld_MSVC.lib  @link.rsp
  ---- or ----
link Sample_B.OBJ               @link.rsp



The executable program Sample_DLL.exe contains a single call to 
the INTERP function. It does not use the other three functions in 
the DLL.  The program reads solution file Septum.T35, which can 
be created by running Automesh and Poisson on the input file 
Septum.am in directory Examples\Magnetostatic\Septum.  The code 
created from Sample_B.ccp displays two pop-up messages.  The first 
one announces whether the DLL loaded successfully or not.  If it did, 
the next message tells the status of the call to the INTERP function. 
If successful, the program appends the following information to file 
output.txt:

x:5
y:5
Solution:-5477.12
X component:1563.84
Y component:-4460.87
dBy/dy:-731.758
dBy/dx:2397.91
dBx/dy:2397.91




Interpolating fields from multiple solution files

Subroutine INTERP in the dynamic link library will automatically switch 
between different .T35 solution files whenever the name of the file on 
the calling line changes.  However, switching between files very often 
may cause an application to run very slowly.  To avoid this problem,
an application can keep open up to 4 different solution files if the 
program is linked with additional DLLs provided separately in WinZip 
file MultiDLL.zip on the LAACG FTP servers.  After downloading this
file, extract the following additional files to the msvc subdirectory:

fld1_msvc.dll, fld2_msvc.dll, fld3_msvc.dll   Dynamic link libraries
fld1_msvc.obj, fld2_msvc.obj, fld3_msvc.obj   Object modules 
fld1_msvc.lib, fld2_msvc.lib, fld3_msvc.lib   Import libraries  


Each DLL contains the same the four functions as fld_msvc.dll, but the 
functions have the number 1, 2, or 3 appended to their names.  For
example, file fld1_msvc.dll contains functions INTERP1, I_Variable1,
R_Variable1, and GetTitle1.



Following are the results of executing the command 
dumpbin /exports fld_msvc.dll

Microsoft (R) COFF Binary File Dumper Version 6.00.8447
Copyright (C) Microsoft Corp 1992-1998. All rights reserved.


Dump of file fld_msvc.dll

File Type: DLL

  Section contains the following exports for fld_msvc.dll

           0 characteristics
    40E4256E time date stamp Thu Jul 01 08:53:34 2004
        0.00 version
           1 ordinal base
           4 number of functions
           4 number of names

    ordinal hint RVA      name

          1    0 000047F0 _GETTITLE@4
          2    1 00001000 _INTERP@36
          3    2 00003770 _I_VARIABLE@4
          4    3 000040D0 _R_VARIABLE@4

  Summary

      193000 .data
       26000 .rdata
       1A000 .reloc
        9000 .rsrc
      103000 .text
        1000 codeseg
