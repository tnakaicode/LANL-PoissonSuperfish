Echo off
cls
Echo This batch file demonstrates building an Absoft Fortran main 
Echo program that uses the interpolator in dynamic link library 
Echo Fld_Abs.DLL.
Echo This file should work as distributed if you run it from the 
Echo the Absoft Fortran Development Command Shell.  If you are not 
Echo now in that tool, please stop, launch the Development Command 
Echo Shell, navigate to this directory, and type command Run_Abs.Bat.
Echo Press CTRL-C to stop now.

pause


Echo The next step deletes any existing fld_abs.lib file and then 
Echo runs Imptool to create a new import library fld_abs.lib 
Echo compatible with the Absoft Fortran language system.

pause
  
if exist fld_abs.lib  del /q fld_abs.lib  
imptool -def:fld_abs.def -out:fld_abs.lib


Echo Ready to start the Absoft graphical user interface. When
Echo the code starts, highlight the name of the Fortran source
Echo file, perform the build operation, and then quit to return 
Echo to this batch file.  Respond No when asked if you want to 
Echo save changes to file sample_abs.gui. 

pause

sample_abs.gui


Rem  If the TAPE35 file for problem HTEST1 already exists in this 
Rem  directory, skip running the codes to create it.

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
Echo Ready to run SAMPLE_Abs, then Quikplot to display the results.
Echo After ending program Quikplot, this batch file will end.

pause

sample_Abs.exe
quikplot htest1.qkp

