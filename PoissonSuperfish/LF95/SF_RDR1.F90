!     Last change:  JHB  29 Nov 2005   10:18 am
!  Subroutine RDRECORD1.  This routine reads the first record of file TAPE35 data written
!  by programs Automesh, Fish, CFish, Autofish, SFO, Poisson, and Pandira.
!
!  Copyright 1998-2005, by the University of California.
!  Unauthorized commercial use is prohibited.
!
!  If you are a programmer writing your own post processors for Poisson or Superfish problems,
!  you may include this Lahey FORTRAN source file in your own code.  You are free to modify this
!  file as needed for your own use.
!
!  The original Poisson Superfish codes were developed by R. F. Holsinger in collaboration with
!  Klaus Halbach.  These codes are supported by James H. Billen and Lloyd M. Young.
!
!  The library LANLSF.LIB contains the object module created from file SF_RDT35.F90, which also
!  includes this file when compiled.  All applications can use the library version of RDRECORD1.
!  This source code is provided for code developers who may wish to:
!  1. Modify, omit, or add error detection and messages.
!  2. Read a TAPE35 file containing additional records written, for example, by their own postprocessor.
!
!  You are free to modify this file as needed for your own use.  See the section "Files
!  provided for program developers" in the Poisson Superfish documentation for a description
!  of this file and the variables used in the field interpolator.  This file is provided as
!  is, without any additional documentation other than that mentioned above.
!
      subroutine rdrecord1
      USE PoissonSuperfishData
      USE SF_CTRL
      IMPLICIT NONE
      INTEGER (KIND=4),EXTERNAL  :: integerdate
      LOGICAL (KIND=4)    :: fopen=.false.
      CHARACTER (LEN=256) :: path35=' '
      CHARACTER (LEN=12)  :: cdate=' '
      CHARACTER (LEN=24)  :: dt35=' '
      CHARACTER (LEN=10)  :: date35='4-20-1997' ! Next time this date changes, remove lines marked !TEMP in RDTAPE35.
      character (LEN=10)  :: problemtype(0:1)=(/'Poisson   ','Superfish '/)
      INTEGER (KIND=4)  :: i=0,new35form=0,idate=0,idate35=0,istatus=0,istatus1=0,isize=0
!
!  NEW35FORM is the date of the most recent change to the structure of binary file TAPE35.
!  If reading a TAPE35 file older than this, write an error message and stop.  Source-code
!  developers may wish to remove the next few lines of code, unless the library LANLSF.LIB is
!  linked with the application.  Source code for the routines FILEINFO and INTEGERDATE are
!  not provided with this distribution, but object modules appear in the library.
!
      kxt35=0
      REWIND(35)
      fopen=.false.
      if(nout.ne.-1)inquire(unit=nout,opened=fopen)
      new35form=integerdate(date35)
      call fileinfo(tape35,path35,dt35,isize)
      idate35=integerdate(dt35)
!
!  Check for an out-of-date solution file.
!
      if(new35form.ge.idate35)then
        i=1
        do WHILE(dt35(i:i).eq.' ')
          i=1+1
        end do
        kerror=222
        if(fopen)then
          write(nout,1000)kerror,trim(T35File),dt35(i:10),trim(date35)
1000      format(/'Error',i4/&
          'File ',a,' was produced on ',a,' by'/&
          'a previous version of the codes.  The structure'/&
          'of the binary solution file changed on ',a,'.'/&
          'Rerun the problem starting with program Automesh.')
        endif
        longmsg=&
        'This file was produced on '//dt35(i:10)//' by a previous version of the codes.  The structure of the binary '//&
        'solution file changed on '//trim(date35)//'.'
        IF(maincode.eq.'WSFPLOT')return
        longmsg=TRIM(longmsg)//crcr//&
        'Rerun the problem starting with program Automesh.'
        i=LEN_TRIM(T35File)
        IF(IsNotDLL)then
          call WarningMessage(longmsg,MessageTime,BoxTitle=T35File(1:i))
        endif
        return
      endif
      Record1Type=0
      read(35,IOSTAT=istatus)(con(i),icon(i),namep(i),i=1,ncon),ntitle,title,originatingcode,&
      probtype,probfile,probdate,iprobsize
!
!  There are two types of older records that the code may encounter.  A change in Feb 2002 made
!  all filename variables 256 characters instead of 64 characters.  Around Jan 2000, the PROBDATE
!  variable chaged from 16 to 24 characters.  If an error occurs of reading, first try reading
!  with the old size of the PROBFILE variable.  If that does not work, try both old PROBFILE and
!  old PROBDATE variables.  Convert the strings to the new format.
!
      if(istatus.ne.0)then
        REWIND(35)
        read(35,IOSTAT=istatus1)(con(i),icon(i),namep(i),i=1,ncon),ntitle,title,originatingcode,&
        probtype,probfile64,probdate,iprobsize
        IF(istatus1.eq.0)then
          probfile=probfile64
          Record1Type=1
        else
          REWIND(35)
          read(35,err=990,end=990)(con(i),icon(i),namep(i),i=1,ncon),ntitle,title,originatingcode,&
          probtype,probfile64,oldprobdate,iprobsize
          Record1Type=2
          cdate=oldprobdate(1:8)
          call date2num(cdate,idate)
          call num2date(cdate,idate)
          probdate=TRIM(cdate)//'  '//TRIM(oldprobdate(11:))//':00'
        endif
      endif
      newprobdate=probdate
      kprob=icon(1)
      call ExtractCONarray
!
!  Starting 8/21/2001, material array lengths are user definable.  Set previous defaults.
!
      if(maxmat.le.0)then                                       !TEMP
        maxmat=20                                               !TEMP
        mintable=-1                                             !TEMP
      endif                                                     !TEMP
      if(maxtable.le.0)then                                     !TEMP
        maxtable=16                                             !TEMP
      endif                                                     !TEMP
      if(kprobr.ne.-1.and.kprob.ne.kprobr)then
        kerror=223+kprobr
        if(fopen)then
          write(nout,1400)kerror,trim(T35File),trim(problemtype(kprob)),trim(problemtype(kprobr))
1400      format(/'Error',i4/&
          'File', a,' contains a ',a,' problem, not a ',a,' problem.')
        endif
        write(longmsg,14001)trim(T35File),trim(problemtype(kprob)),trim(problemtype(kprobr))
14001   format('File ',a,' contains a ',a,' problem, not a ',a,' problem.')
        call TimedMessage(longmsg,MessageTime)
        return
      endif
      return
990   kerror=207
      kxt35=1
      end subroutine

