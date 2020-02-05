Echo off
cls
Echo This batch file demonstrates building a LF95 main program that
Echo uses the interpolator in dynamic link library Fld_LF95.DLL.
Echo This file will work as distributed only if the Lahey Fortran 
Echo compiler LF95 plus the Winteracter 4.0 development tools are 
Echo installed on your machine and included in the PATH. 
Echo Press CTRL-C to stop now.
pause


Echo Compiling SAMPLE_DLL.F90 using Lahey LF95. 
Echo Linking with the dynamic link library Fld_LF95.DLL.

lf95 sample_dll.f90 -nfix -nf90 -ml lf95  Fld_LF95.lib  
pause

del /q sample_dll.obj  >nul
del /q sample_dll.map  >nul

Rem  If the TAPE35 file for problem HTEST1 already exists in this directory
Rem  skip running the codes to create it.

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
Echo Press "OK" when the SAMPLE_DLL message appears indicating that
Echo the Quikplot file has been created.  
Echo After ending program Quikplot, this batch file will end.

pause
sample_dll
quikplot htest1.qkp

