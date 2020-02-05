!     Last change:  JHB  13 Mar 2003    4:30 pm
!  File SAMPLE.F90.
!
!  This Lahey Fortran 90 source program is provided as an example for
!  source code developers.  This program reads the TAPE35 solution file
!  for the HTEST1 example and produces a Quikplot input file containing
!  By versus X.
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
      program sample
      USE PoissonSuperfishData
      USE MaterialData
      INCLUDE 't35array.inc'
      USE InterpolatedFields
      USE SF_CTRL
      USE SF_Menued
      IMPLICIT NONE
      INTEGER (KIND=4) :: j=0,iee=0
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
      tape35='HTEST1.T35'
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
      allocate(xx(itot),yy(itot),avector(itot),source(itot),irlax(itot),iregup(itot),&
      iregdn(itot),kscat(itot),kfilt(itot),ngo(itot),mat(0:nreg),den(0:nreg),&
      bt(201,mintable:maxtable),gt(201,mintable:maxtable),aeasymt(mintable:maxtable),&
      gampermt(mintable:maxtable),x0amt(mintable:maxtable),y0amt(mintable:maxtable),&
      phiamt(mintable:maxtable),amultmt(mintable:maxtable),hceptmt(mintable:maxtable),&
      bceptmt(mintable:maxtable),gammamt(mintable:maxtable),mtid(mintable:maxtable),&
      mtlength(mintable:maxtable),mtypemt(mintable:maxtable),mattbli(0:maxmat),&
      mshapemt(0:maxmat),stacki(0:maxmat),stat=iee)
      if(iee.ne.0)then
        call WMessageBox(OKOnly,StopIcon,CommonOK,'There is not'//&
        ' enough memory available to start the program.','Error')
        call IOsExitProgram(' ',1)
      endif
        xx=0.0d0
        yy=0.0d0
        avector=0.0d0
        source=0.0d0
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
        bt=0.0d0
        gt=0.0d0
        aeasymt=0.0d0
        gampermt=0.0d0
        x0amt=0.0d0
        y0amt=0.0d0
        phiamt=0.0d0
        amultmt=0.0d0
        hceptmt=0.0d0
        bceptmt=0.0d0
        gammamt=0.0d0
        mtid=0
        mtlength=0
        mtypemt=0
        mattbli=0
        mshapemt=0
        stacki=0.0d0
!
!  This use of RDTAPE35 mimics program SF7.  Before calling the
!  subroutine, set the last element of arrays to values required
!  in RDTAPE35 to verify the array lengths.
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
      bt(201,maxtable)=findef
      gt(201,maxtable)=findef
      aeasymt(maxtable)=findef
      gampermt(maxtable)=findef
      gammamt(maxtable)=findef
      x0amt(maxtable)=findef
      y0amt(maxtable)=findef
      phiamt(maxtable)=findef
      amultmt(maxtable)=findef
      hceptmt(maxtable)=findef
      bceptmt(maxtable)=findef
      mtlength(maxtable)=-99
      mtypemt(maxtable)=-99
      stacki(maxmat)=findef
      mattbli(maxmat)=-99
      mshapemt(maxmat)=-99
      call rdtape35
      if(kerror.gt.0)call IOsExitProgram(' ',kerror)
!
!  Open a text file and write By versus X to a Quikplot data file.
!  Poisson Superfish length variables are in cm.  CONV is the units
!  conversion factor (e.g., CONV = 2.54 if user's units are inches).
!  The field interpolator always uses cm.  For printing results in
!  the Quikplot file, use user's units.
!
      open(45,file='HTEST1.QKP',ACTION='WRITE')
      write(45,'(a)')'; File HTEST1.QKP',&
      '; Sample Quikplot file using the Poisson Superfish field interpolator'//nln,&
      'Center',&
      'Title',&
      'By versus x from Poisson/Pandira problem: '//TRIM(title(1))//nln
      IF(title(2).ne.' ')then
        write(45,'(a)')'Subtitle',TRIM(title(2))//nln
      endif
      IF(title(3).ne.' ')then
        write(45,'(a)')';Remaining title lines:'
        do j=3,10
          IF(title(j).ne.' ')write(45,'(a)')';'//TRIM(title(j))
        enddo
      endif
      write(45,'(a)')nln,'XLabel','X Position (cm)','YLabel','By (Gauss)'//nln,'Data'
      yedit=0.0d0
      xinc=xmaxg/200.0d0
      do j=0,200
        xedit=DBLE(j)*xinc
        call interpolate(-1)
        write(45,"(2e15.7)")xedit/conv,by
      enddo
      write(45,'(a)')'EndData'//nln,'EndFile'
      CLOSE(45)
      call WMessageBox(OKOnly,InformationIcon,CommonOK,&
      'File HTEST1.QKP has been created.'//crtn//&
      'Double-click on this file to run'//crtn//&
      'Quikplot and view By versus x.','Program Completed')
      call IOsExitProgram(' ',0)
      end program
!
!  Uncomment the following line if you need to compile a modified
!  version of the RDTAPE35 subroutine with the code.  For most
!  applications the module in LANLSF.LIB will suffice.
!
!      include 'sf_rdt35.f90'

