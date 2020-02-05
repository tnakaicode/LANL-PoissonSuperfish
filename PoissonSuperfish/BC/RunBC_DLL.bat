Echo off
cls
Echo This batch file demonstrates building a Borland C main program 
Echo that uses the interpolator in dynamic link library Fld_BC.DLL.
Echo The C source file was developed by Harunori Takeda of Los Alamos
Echo National Laboratory using Borland C++ version 5.2.  
Echo This file will work as distributed only if the Borland C
Echo compiler is installed on your machine and included in the PATH. 
Echo Press CTRL-C to stop now.

pause

Echo The next step creates the import library fld_bc.lib
Echo compatible with the Borland C language system.

pause
  
if exist fld_bc.lib del /q fld_bc.lib
implib fld_bc.lib fld_bc.dll

Echo Ready to generate a response file for the compiler and then
Echo run the C compiler.
 
pause

Echo on
echo -W -6 -d -k- -H- -R- -K -w -X -Otilmpv -DSYSTEM=WIN32 > bcc.rsp
if exist Sample_DLL.exe del /q Sample_DLL.exe 
bcc32 @bcc.rsp Sample_DLL.c  fld_bc.lib
Echo off

Rem  If file HTEST1.T35 for problem HTEST1 already exists in this
Rem  directory skip running the codes to create it.

if exist HTEST1.T35 goto runhtest

Echo Ready to run Automesh and Poisson to generate a TAPE35 
Echo solution file for the H-MAGNET\HTEST1 problem.  
Echo After program Poisson ends, return to this batch file
Echo to continue.

pause

copy     %SFDIR%\Examples\Magnetostatic\h-magnet\htest1.am
automesh  htest1.am
poisson   htest1.t35

:runhtest
Echo Ready to run SAMPLE_DLL, then Quikplot to display the results.
Echo After ending program Quikplot, this batch file will end.

pause

sample_dll.exe
quikplot htest1.qkp
