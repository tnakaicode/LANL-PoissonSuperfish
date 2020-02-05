!     Last change:  JHB  13 Mar 2003    4:30 pm
!  File SAMPLE2.F90.
!
!  This Lahey Fortran 90 source program is provided as an example for
!  source code developers.  This program reads the TAPE35 solution file
!  for the COAXWG example and produces a Tablplot input file containing
!  Er and Ez versus Z.
!
!  Copyright 1998, by the University of California.
!  Unauthorized commercial use is prohibited.
!
!  You are free to modify this file as needed for your own use.  See
!  the section "Files provided for program developers" in the Poisson
!  Superfish documentation for a description of this file and the
!  variables used in the field interpolator.  This file is provided
!  as is, without any additional documentation other than that mentioned
!  above.
!
!  Los Alamos National Laboratory cannot provide consulting for source-
!  code developers.
!
      program sample2
      USE PoissonSuperfishData
      USE MaterialData
      INCLUDE 't35array.inc'
      USE InterpolatedFields
      USE SF_CTRL
      USE SF_Menued
      IMPLICIT NONE
      CHARACTER (LEN=100)  :: messagebuffer=' '
      INTEGER (KIND=4) :: j=0,iee=0,nm=0,nregion=0
      REAL (KIND=8) :: xinc=0.0
      CALL WInitialise(' ')
!
!  Create a hidden root window (required so that pop-up error routines
!  in LANLSF.LIB function properly).
!
      WINDOW%FLAGS=SysMenuOn+HideRoot
      CALL WindowOpen(WINDOW)
      call WDialogLoad(IDD_Information)  ! Dialog may be needed in RDTAPE35
!
!  Open the TAPE35 file to get the size of the problem arrays.
!  RDTAPE35 automatically rewinds unit 35 and rereads record 1.
!
      pi=4.0d0*atan(1.0d0)
      tape35='COAXWG.T35'
      if(.not.fexist(tape35))then
        call WMessageBox(OKOnly,StopIcon,CommonOK,' The file '//trim(tape35)//' does not exist.','Error')
        call IOsExitProgram(' ',1)
      endif
      open(35,file=tape35,form='unformatted',ACTION='READ')
      call rdrecord1
      if(kerror.gt.0)then
        if(kxt35.eq.1)then
          call WMessageBox(OKOnly,StopIcon,CommonOK,' An error occurred reading the first record from file '//&
          trim(tape35)//'.','Error')
        endif
      call IOsExitProgram(' ',1)
      endif
!
!  Allocate the arrays and call RDTAPE35.
!
      allocate(xx(itot),yy(itot),avector(itot),irlax(itot),iregup(itot),iregdn(itot),&
      kscat(itot),kfilt(itot),ngo(itot),mat(0:nreg),den(0:nreg),epsmt(maxtable),fmumt(maxtable),&
      reps(0:maxtable),fmu(0:maxtable),stat=iee)
      if(iee.ne.0)then
        call WMessageBox(OKOnly,StopIcon,CommonOK,'There is not'//&
        ' enough memory available to start the program.','Error')
      call IOsExitProgram(' ',1)
      endif
        xx=0.0d0
        yy=0.0d0
        avector=0.0d0
        irlax=0
        iregup=0
        iregdn=0
        kscat=0
        kfilt=0
        ngo=0
        mat=0
        den=0.0d0
        epsmt=0.0d0
        fmumt=0.0d0
        reps=0.0d0
        fmu=0.0d0
!
!  This use of RDTAPE35 mimics program SF7.  Before calling the
!  subroutine, set the last element of declared arrays to values
!  required in RDTAPE35 to verify the existence of the arrays.
!
      xx(itot)=findef
      yy(itot)=findef
      avector(itot)=findef
      irlax(itot)=-99
      iregup(itot)=-99
      iregdn(itot)=-99
      kscat(itot)=-99
      kfilt(itot)=-99
      ngo(itot)=-99
      mat(nreg)=-99
      den(nreg)=findef
      iccc=2
      itot1=itot  ! Set to ITOT to return XX, YY, AVECTOR, etc.
      itot2=1     ! Set to ITOT to return SOURCE array.
      itot3=1     ! Set to ITOT to return GTL, GTU arrays.
      nareg=nreg  ! Set to NREG.
      nwtot=1     ! Set to NWMAX to return JNDEX and JUP arrays.
      naseg=1
      nabound=1   ! Set to NPBOUND to return arrays NPENDS and IROWBOUND.
      nbspl=1     ! Set to NSPL to return AVECINI and NBDRIVE arrays.
      epsmt(maxtable)=findef
      fmumt(maxtable)=findef
      call rdtape35
      if(kerror.gt.0)call IOsExitProgram(' ',kerror)
!
!  Transfer the material data to the REPS and FMU arrays for use
!  in the field interpolator.
!
      reps(0)=0.0d0
      fmu(0)=0.0d0
      reps(1)=1.0d0
      fmu(1)=1.0d0
      if(nmatr.gt.0)then
        do nregion=1,nreg
          nm=mat(nregion)
          if(nm.le.1)cycle
          if(abs(dble(epsmt(nm))-findef).lt.ftoler.or. abs(dble(fmumt(nm))-findef).lt.ftoler)then
            write(messagebuffer,1100)trim(tape35),nm
1100        format('File ',a,' does not include material data for material ID',i3)
            call WMessageBox(OKOnly,StopIcon,CommonOK,messagebuffer,'Error')
            call IOsExitProgram(' ',1)
          endif
          reps(nm)=1.0d0/epsmt(nm)
          fmu(nm)=fmumt(nm)
        enddo
      endif
!
!  Open a text file and write fields to a Tablplot data file.
!  Poisson Superfish length variables are in cm.  CONV is the units
!  conversion factor (e.g., CONV = 2.54 if user's units are inches).
!  The field interpolator always uses cm.  For printing results in
!  the Tablplot file, use user's units.
!
      open(45,file='COAXWG.TBL',ACTION='WRITE')
      write(45,'(a)')'; File COAXWG.TBL','; Sample Tablplot file'//&
      ' using the Poisson Superfish field interpolator'//nln,&
      'Center','Title',&
      'Er and Ez versus Z from CFish problem: '//trim(title(1))//nln,&
      'SubTitle',trim(title(2))//nln,&
      'Markersize -0.4',&
      'YLabel','Ez,Er (MV/m)',&
      'Abscissa 1',&
      'Ordinate 2 3'//nln,&
      'Titles','Z','Ez','Er','H','EndTitles'//nln,&
      'AxisLabels','Z (cm)','Ez (MV/m)','Er (MV/m)','H (A/m)',&
      'EndLabels'//nln,&
      'CurveLabels','Z','Ez','Er','H','EndLabels'//nln,&
      'Data',&
      ';      Z          Ez            Er           H',&
      ';    (cm)       (MV/m)        (MV/m)       (A/m)'
      xinc=xmaxg/200.0d0
      yedit=2.5d0
      do j=0,200
        xedit=DBLE(j)*xinc
        call interpolate(-1)
!
!  Scale the field components to MV/m and A/m. Write only the real part.
!
        ez=ez*ascale*1.0d-4
        er=er*ascale*1.0d-4
        h=25.0d9*h*ascale/(pi*clight)
        write(45,"(f10.5,1p,3e14.6)")xedit/conv,dble(ez),dble(er),dble(h)
      enddo
      write(45,'(a)')'EndData'//nln,'EndFile'
      CLOSE(45)
      call WMessageBox(OKOnly,InformationIcon,CommonOK,&
      'File COAXWG.TBL has been created.'//crtn//&
      'Double-click on this file to run'//crtn//&
      'Tablplot and view Ez and Er versus z.','Program Completed')
      call IOsExitProgram(' ',0)
      end program
!
!  Uncomment the following line if you need to compile a modified
!  version of the RDTAPE35 subroutine with the code.  For most
!  applications the version in LANLSF.LIB will suffice.
!
!      include 'sf_rdt35.f90'

