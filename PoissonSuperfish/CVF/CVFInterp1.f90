 Program CVFInterp1
! -----------------------------------------------------------------------------
! This program demonstatres the use of the INTERP function  
! of the Poisson Superfish Version 7 library using Compaq Visual Fortran.
! Project type: Fortran Console-Application
! Compiler options all defaults
! Linker options: all default
! External library: fld_CVF.lib (Poisson Superfish Version 7)
! 
!
! Author: Tibor Kibedi (Tibor.Kibedi@anu.edu.au)
!	  Department of Nuclear Physics, Australian National University
!	  Canberra, ACT 0200, Australia
! -----------------------------------------------------------------------------
 Implicit None
 CHARACTER (LEN=256) :: SolutionFile
 REAL (KIND=8) :: Xvalue,Yvalue
 REAL (KIND=8) :: Solution,Xcomponent,Ycomponent
 REAL (KIND=8) :: DBYDY,DBYDX,DBXDY
 Integer (KIND=4) :: Iostat1
! -----------------------------------------------------------------------------
Interface
! -----------------------------------------------------------------------------
 Integer*4 function INTERP(SolutionFile,Xvalue,Yvalue, &
          Solution,Xcomponent,Ycomponent,DBYDY,DBYDX,DBXDY);
   !DEC$ ATTRIBUTES NOMIXED_STR_LEN_ARG, DLLIMPORT, ALIAS : '_INTERP@36' :: INTERP
   CHARACTER(LEN=256),INTENT(IN) :: SolutionFile
   !DEC$ ATTRIBUTES NOMIXED_STR_LEN_ARG :: SolutionFile
   REAL (KIND=8),INTENT(IN) :: Xvalue,Yvalue
   REAL (KIND=8),INTENT(OUT) :: Solution,Xcomponent,Ycomponent
   REAL (KIND=8),INTENT(OUT) :: DBYDY,DBYDX,DBXDY
  End Function INTERP
End Interface

! -----------------------------------------------------------------------------
 SolutionFile='htest1.t35'
     OPEN(10,FILE='out.txt')
     WRITE(10,1000)
1000 FORMAT('   Xvalue  Yvalue  Solution       Xcomponent     Ycomponent     DBYDY          DBYDX          DBXDY')
     CLOSE(10)
 Do
   Write(6,'(a)') ' X-coordinate to extrapolate:'
   Read (5,*) Xvalue
   Write(6,'(a)') ' Y-coordinate to extrapolate:'
   Read (5,*) Yvalue
   Iostat1 = INTERP(SolutionFile, &
                   Xvalue, Yvalue, &
                   Solution, Xcomponent, Ycomponent, &
		     DBYDY, DBYDX, DBXDY)
  Select Case (IoStat1)
! -----------------------------------------------------------------------------
!  0	The operation completed successfully.
! -----------------------------------------------------------------------------
  Case (0)
     Write(6,1001)Xvalue, Yvalue, Solution, Xcomponent, Ycomponent, DBYDY, DBYDX, DBXDY
1001 FORMAT('   Xvalue  Yvalue  Solution       Xcomponent     Ycomponent     DBYDY          DBYDX          DBXDY'/&
    1x,2f8.4,6 d15.7)
    OPEN(10,FILE='out.txt',POSITION='APPEND')
    WRITE(10,1002)Xvalue, Yvalue, Solution, Xcomponent, Ycomponent, DBYDY, DBYDX, DBXDY
1002 FORMAT(1x,2f8.4,6 d15.7)
    CLOSE(10)
! -----------------------------------------------------------------------------
  Case (-1)
    Write(6,'(a)')'The solution file does not exist.'
    Stop
! -----------------------------------------------------------------------------
  Case (-2)
    Write(6,'(a)')'Unable to allocate solution arrays, usually not enough memory.'
    Stop
! -----------------------------------------------------------------------------
  Case (-3)
    Write(6,'(a)') 'The solution does not include the point X,Y.'
! -----------------------------------------------------------------------------
  Case (-4)
    Write(6,'(a)')'Function INTERP was unable to determine the solution file version.'
    Stop
! -----------------------------------------------------------------------------
  Case (-5)
    Write(6,'(a)')'Cannot read solution files written by Poisson Superfish version 6.'
    Stop
! -----------------------------------------------------------------------------
  Case (207)
    Write(6,'(a)') 'An error occurred reading the first record from the Poisson Superfish solution file.'
    Stop
! -----------------------------------------------------------------------------
  Case (208)
    Write(6,'(a)') 'Solution arrays have not been properly declared. Please report this error.'
    Stop
! -----------------------------------------------------------------------------
  Case (209)
    Write(6,'(a)') 'The dimension of at least one solution array is too small. Please report this error.'
    Stop
! -----------------------------------------------------------------------------
  Case (210)
    Write(6,'(a)') 'Mesh point arrays are not large enough. Please report this error.'
    Stop
! -----------------------------------------------------------------------------
  Case (216)
    Write(6,'(a)') 'Unable to read triangular mesh data (possibly incompatible code versions).'
    Stop
! -----------------------------------------------------------------------------
  Case (217)
    Write(6,'(a)') 'The solution file for a Superfish problem contains only mesh data and no solution arrays.'
    Stop
! -----------------------------------------------------------------------------
  Case (218)
    Write(6,'(a)') 'The solution file for a Poisson problem contains only mesh data and no solution arrays.'
    Stop
! -----------------------------------------------------------------------------
  Case (220)
    Write(6,'(a)') 'Reached the end of the solution file unexpectedly. Rerun problem stating with Automesh. '
    Stop
! -----------------------------------------------------------------------------
  Case (221)
    Write(6,'(a)') 'An error occurred reading a record from the solution file. Please report this error.'
    Stop
! -----------------------------------------------------------------------------
  Case (222)
    Write(6,'(a)') 'The Poisson Superfish solution file is obsolete.'
    Stop
! -----------------------------------------------------------------------------
  Case Default
    Write(6,'(a)') 'Unexpected error code.'
    Stop
! -----------------------------------------------------------------------------
  End Select
 End Do
Stop
End
