!     Last change:  JHB  10 Feb 2003    6:08 pm
!  File SAMPLE_Abs.F90.
!
!  This Lahey Fortran 90 source program is provided as an example for
!  source code developers.  This program reads the TAPE35 solution file
!  HTEST1.T35 from H-Magnet example by calling the INTERP function in
!  file Fld_LF90.DL.  The code produces the same result as the LF95
!  program Sample.f90, which links to object modules in a Fortran 95
!  library.  Output is Quikplot input file containing By versus X.
!
!  Copyright 2003, by the University of California.
!  Unauthorized commercial use is prohibited.
!
!  You are free to modify this file as needed for your own use.  See
!  the section "Files provided for program developers" in the Poisson
!  Superfish documentation for a description of the field interpolator
!  calling parameters.  This file is provided as is, without any
!  additional documentation other than that mentioned above.
!
!  Los Alamos National Laboratory cannot provide consulting for source-
!  code developers.
!
      program sample
      IMPLICIT NONE
      INTEGER (KIND=4),EXTERNAL    :: INTERP
      INTEGER (KIND=4),EXTERNAL    :: I_VARIABLE
      REAL (KIND=8),EXTERNAL       :: R_VARIABLE
      INTEGER (KIND=4),EXTERNAL    :: GETTITLE
      dll_import INTERP
      dll_import I_VARIABLE
      dll_import R_VARIABLE
      dll_import GETTITLE    
      INTEGER (KIND=4) :: j=0,Iresult=0
      REAL (KIND=8) :: conv=0.0,xinc=0.0,Xmax=0.0,Xval=0.0,Yval=0.0,&
      Bx=0.0,By=0.0,Az=0.0,DBYDY=0.0,DBYDX=0.0,DBXDY=0.0
      CHARACTER (LEN=80),DIMENSION(10) :: Title=' '
      CHARACTER (LEN=256)  :: SolutionFile=' '
      CHARACTER (LEN=8)    :: VName=' '
      CHARACTER (LEN=8)    :: Ecode=' '
      CHARACTER(LEN=2),PARAMETER :: NEWLIN=CHAR(13)//CHAR(10)
!
!  Select the TAPE35 file containing the H-magnet solution. The first call to
!  the function INTERP opens and reads the solution file.
!
      SolutionFile='HTEST1.T35'
      Xval=0.0d0
      Yval=0.0d0
      Iresult=INTERP(SolutionFile,Xval,Yval,Az,Bx,By,DBYDY,DBYDX,DBXDY)
      SELECT CASE (Iresult)
        CASE (0)   ! Operation successful. continue with program.
        CASE (-1)  ! No such file
        write(*,*)'The file '//trim(SolutionFile)//' does not exist.'
          pause
          stop
        CASE (-2)  ! DLL could not allocate arrays
          write(*,*) 'Function INTERP was unable to '//&
          'allocate solution arrays.'
          pause
          stop
        CASE (-3)   ! File read successfully, but point not in problem. Continue with program.
        CASE (-4)   ! DLL could not determine solution file version
          write(*,*) 'Function INTERP was unable to '//&
          'determine the solution file version.'
          pause
          stop
        CASE (-5)   ! DLL cannot read version 6 files
          write(*,*) 'Function INTERP cannot read '//&
          'solution files written by Poisson Superfish version 6.'
          pause
          stop
          CASE (100:999)
          WRITE(Ecode,'(i4)')Iresult
          write(*,*)'Function INTERP returned error code'//&
          TRIM(Ecode)//'. Refer to Table II-6 in file SFintro.DOC.'
          pause
          stop
        CASE DEFAULT
          WRITE(Ecode,'(i8)')Iresult
          write(*,*)'Function INTERP returned an unknown'//&
          'error code: '//TRIM(Ecode)//'. Please report the problem to Superfish@lanl.gov.'
          stop
      END SELECT
!
!  Poisson Superfish length variables are in cm.  CONV is the units conversion
!  factor (e.g., CONV = 2.54 if user's units are inches).  Function INTERP assumes
!  Xval and Yval are in user's units.

!
      Vname='CONV'
      conv=R_Variable(Vname)
!
!  Get the maximum X coordinate in the problem and convert to user's units.
!
      Vname='XMAXG'
      Xmax=R_Variable(Vname)/conv
!
!  Get the ten 80-character title lines.
!
      iResult=GetTitle(Title)
!
!   Open a text file and write By versus X to a Quikplot data file.
!
      open(45,file='HTEST1.QKP',ACTION='WRITE')
      write(45,'(a)')'; File HTEST1.QKP',&
      '; Sample Quikplot file using the Poisson Superfish field'//&
      ' interpolator',' ',&
      'Center','Title',&
      'By versus x from Poisson/Pandira problem:'//TRIM(title(1)),' ',&
      'XLabel','X Position (cm)',&
      'YLabel','By (Gauss)',' ',&
      'Data'
      Yval=0.0d0
      xinc=Xmax/200.0d0
      do j=0,200
        Xval=DBLE(j)*xinc
        Iresult=INTERP(SolutionFile,Xval,Yval,Az,Bx,By,DBYDY,DBYDX,DBXDY)
        IF(Iresult.ne.0)cycle
        write(45,"(2e15.7)")Xval,By
        enddo
      write(45,'(a)')'EndData',' ','EndFile'
      CLOSE(45)
      write(*,*)'File HTEST1.QKP has been created.'//newlin//&
      'Double-click on this file to run'//newlin//&
      'Quikplot and view By versus x.','Program Completed'
      pause
      stop
      end program

