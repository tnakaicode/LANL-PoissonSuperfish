Echo off
cls
Echo This batch file demonstrates building a LF95 main program that
Echo uses the interpolator in Fortran library LANLSF.LIB.
Echo This file will work as distributed only if the Lahey Fortran 
Echo compiler LF95 plus the Winteracter development tools are 
Echo installed on your machine and included in the PATH. 
Echo Press CTRL-C to stop now.
pause


Echo Compiling SAMPLE.F90 and SAMPLE2.F90 using Lahey LF95. 
Echo Linking with the library containing RDTAPE35 and INTERPOLATE.

lf95 -o1 -ng sample.f90   -lib lanlsf.lib  
lf95 -o1 -ng sample2.f90  -lib lanlsf.lib  
pause


del sample?.obj  >nul


Rem  If the TAPE35 file for problem HTEST1 already exists in this directory
Rem  skip running the codes to create it.

if exist HTEST1.T35 goto runhtest

cls
Echo Ready to run Automesh and Poisson to generate a TAPE35 
Echo solution file for the H-MAGNET\HTEST1 problem.  
Echo After program Poisson ends, return to this batch file
Echo to continue.

pause

copy     %SFDIR%\Examples\Magnetostatic\h-magnet\htest1.am
automesh  htest1
poisson   htest1

:runhtest
cls
Echo Ready to run SAMPLE, then Quikplot to display the results.
Echo Press "OK" when the SAMPLE message appears indicating that
Echo the Quikplot file has been created.  
Echo After ending program Quikplot, return to this batch file
Echo to continue.

pause
sample
quikplot htest1.qkp


Rem  If the TAPE35 file for problem COAXWG already exists in this directory
Rem  skip running the codes to create it.

if exist COAXWG.T35 goto runcoax

cls
Echo Ready to run Automesh, CFish, and SFO to generate 
Echo a TAPE35 solution file for the CFISH\COAXWG problem.
Echo After program SFO ends, return to this batch file
Echo to continue.

pause

copy  %SFDIR%\Examples\RadioFrequency\cfish\coaxwg.am
copy  %SFDIR%\Examples\RadioFrequency\cfish\coaxwg.seg
automesh coaxwg
cfish    coaxwg  
sfo      coaxwg

:runcoax
cls
Echo Ready to run SAMPLE2, then Tablplot to display the results.
Echo Press "OK" when the SAMPLE2 message appears indicating that
Echo the Tablplot file has been created.  
Echo After ending program Tablplot, this batch file will end.

pause
sample2        
tablplot coaxwg.tbl

