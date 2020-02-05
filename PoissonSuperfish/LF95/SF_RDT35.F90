!     Last change:  JHB  29 Nov 2005    9:21 am
!  Subroutine RDTAPE35.  This routine reads TAPE35 data written by programs Automesh, Fish, CFsh,
!  Autofish, SFO, Poisson, and Pandira.
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
!  This routine uses a dialog box contained in RESOURCE.OBJ to report certain error and warning
!  messages. The calling program must include the following statement after initializing Winteracter:
!  call WDialogLoad(IDD_Information)
!
!  The library LANLSF.LIB includes the object module created from this file as distributed.  All
!  applications can use the library version of RDTAPE35, which has been tested extensively.  This
!  source code is provided for code developers who may wish to:
!  1. Modify, omit, or add error detection and messages.
!  2. Read a TAPE35 file containing additional records written, for example, by their own postprocessor.
!
!  You are free to modify this file as needed for your own use.  See the section "Files
!  provided for program developers" in the Poisson Superfish documentation for a description
!  of this file and the variables used in the field interpolator.  This file is provided as
!  is, without any additional documentation other than that mentioned above.
!
      subroutine rdtape35
      USE PoissonSuperfishData
      INCLUDE 't35array.inc'
      USE MaterialData
      USE SF_CTRL
      IMPLICIT NONE
      LOGICAL (KIND=4)    :: fopen=.false.
      CHARACTER (LEN=36)  :: msgstring=' '
      INTEGER (KIND=4) :: i=0,j=0,n=0,itot1_decl=0,itot2_decl=0,itot3_decl=0,nbspl_decl=0,naseg_decl=0,nabound_decl=0,&
      nareg_decl=0,infosize_decl=0,nwtot_decl=0,iccc_decl=0,maxmat_decl=0,maxtable_decl=0,kerrsav=0,irow=0,iflag=0
      REAL (KIND=8) :: rpart=0.0
!
!  The AVECTOR array written by Automesh is never complex, but it might be when written by a later codes.  Calling programs
!  that require a real AVECTOR use the RealTape35Arrays module and programs that require a complex AVECTOR use the
!  ComplexTape35Arrays module.
!
!  Save the values of the declared array sizes in local variables for checking arrays before reading the first record.
!  The calling code may have used variables being read into the CON array.
!
      longmsg=' '
      fopen=.false.
      T35SolutionRead=.false.
      if(nout.ne.-1)inquire(unit=nout,opened=fopen)
      itot1_decl=itot1
      itot2_decl=itot2
      itot3_decl=itot3
      nbspl_decl=nbspl
      naseg_decl=naseg
      nabound_decl=nabound
      nareg_decl=nareg
      infosize_decl=infosize
      nwtot_decl=nwtot
      iccc_decl=iccc
      maxmat_decl=maxmat
      maxtable_decl=maxtable
!
!  Read the first record.
!
      rewind 35
      msgstring='the first record'
      kerrsav=kerror
      call rdrecord1
      if(kxt35.eq.1)then
        go to 990
      else if(kerror.gt.0)then
        return
      endif
!
!  If CHECK35 is true, RDTAPE35 verifies all the arrays declared larger than 1 by the caller.  The caller must set the last
!  element of each requested REAL (KIND=8) or complex*16 array to FINDEF and the last element of integer arrays to -99.  The
!  last element of the character array TPNAME must be blank.  The array length ITOT is the only one that must be larger than 1.
!
      if(check35)then
        if(itot1_decl.lt.itot)then
          kerror=210
          if(fopen)then
          write(nout,1000)kerror
1000        format(/'Error',i4/&
            'Solution arrays have not been declared large enough.')
            WRITE(nout,12130)
12130       FORMAT('Please report this error and send the input'/'file to: Superfish@lanl.gov.')
          endif
          longmsg='The solution arrays have not been declared large enough.'//ReportThisError
          IF(IsNotDLL)then
            call TimedMessage(longmsg,MessageTime)
          endif
          return
        endif                                                            
        msgstring='XX or YY'
        if(abs(xx(itot1_decl)-findef).gt.ftoler.or.abs(yy(itot1_decl)-findef).gt.ftoler)go to 950
        msgstring='IRLAX'
        if(irlax(itot1_decl).ne.-99)go to 950
        msgstring='IREGUP or IREGDN'
        if(iregup(itot1_decl).ne.-99.or.iregdn(itot1_decl).ne.-99)go to 950
        msgstring='KSCAT, KFILT, or NGO'
        if(kscat(itot1_decl).ne.-99.or.kfilt(itot1_decl).ne.-99.or.ngo(itot1_decl).ne.-99)go to 950
        if(kprob.eq.0)then
          msgstring='STACKI, MATTBLI, or MSHAPEMT'
          if(abs(stacki(maxmat_decl)-findef).gt.ftoler.or.mattbli(maxmat_decl).ne.-99.or.mshapemt(maxmat_decl).ne.-99)go to 950
          msgstring='AEASYMT, GAMPERMT, or GAMMAMT'
          if(abs(aeasymt(maxtable_decl)-findef).gt.ftoler.or.abs(gampermt(maxtable_decl)-findef).gt.ftoler.or.&
          ABS(gammamt(maxtable_decl)-findef).gt.ftoler)go to 950
          msgstring='X0AMT or Y0AMT'
          if(abs(x0amt(maxtable_decl)-findef).gt.ftoler.or. ABS(y0amt(maxtable_decl)-findef).gt.ftoler)go to 950
          msgstring='PHIAMT or AMULTMT'
          if(abs(phiamt(maxtable_decl)-findef).gt.ftoler.or.ABS(amultmt(maxtable_decl)-findef).gt.ftoler)go to 950
          msgstring='HCEPTMT or BCEPTMT'
          if(abs(hceptmt(maxtable_decl)-findef).gt.ftoler.or.ABS(bceptmt(maxtable_decl)-findef).gt.ftoler)go to 950
          msgstring='MTLENGTH or MTYPEMT'
          if(mtlength(maxtable_decl).ne.-99.or.mtypemt(maxtable_decl).ne.-99)go to 950
          msgstring='BT or GT'
          if(abs(bt(201,maxtable_decl)-findef).gt.ftoler.or.ABS(gt(201,maxtable_decl)-findef).gt.ftoler)go to 950
        endif
        if(kprob.eq.1)then
          msgstring='EPSMT or FMUMT'
          if(abs(epsmt(maxtable_decl)-findef).gt.ftoler.or.ABS(fmumt(maxtable_decl)-findef).gt.ftoler)go to 950
        endif
        if(nbspl_decl.gt.1)then
          msgstring='AVECINI or NBDRIVE'
          if(nbspl_decl.lt.nspl)go to 940
          if(abs(avecini(nbspl_decl)-findef).gt.ftoler.or.nbdrive(nbspl_decl).ne.-99)go to 950
        endif
        if(naseg_decl.gt.1)then
          msgstring='NBENDS'
          if(naseg_decl.lt.nseg)go to 940
          if(nbends(1,naseg_decl).ne.-99.or.nbends(2,naseg).ne.-99)go to 950
        endif
        if(nabound_decl.gt.1)then
          msgstring='IROWBOUND'
          if(nabound_decl.lt.nseg)go to 940
          if(irowbound(nabound_decl).ne.-99)go to 950
        endif
        if(nareg_decl.gt.1)then
          msgstring='MAT or DEN'
          if(nareg_decl.lt.nreg)go to 940
          if(abs(den(nareg_decl)-findef).gt.ftoler.or.mat(nareg_decl).ne.-99)go to 950
        endif
        if(infosize_decl.gt.1)then
          msgstring='TPVALUE or TPNAME'
          if(infosize_decl.lt.infodata)go to 940
          if(abs(tpvalue(infosize_decl)-findef).gt.ftoler.or.tpname(infosize).ne.' ')go to 950
        endif
        if(itot2_decl.gt.1)then
          msgstring='SOURCE'
          if(itot2_decl.lt.itot)go to 940
          if(abs(source(itot2_decl)-findef).gt.ftoler)go to 950
        endif
        if(itot3_decl.gt.1)then
          msgstring='GTU or GTL'
          if(itot3_decl.lt.itot)go to 940
          if(abs(gtu(itot3_decl)-findef).gt.ftoler.or.abs(gtu(itot3_decl)-findef).gt.ftoler)go to 950
        endif
        if(nwtot_decl.gt.1)then
          msgstring='JNDEX or JUP'
          if(nwtot_decl.lt.nwmax)go to 940
          if(jndex(nwtot_decl).ne.-99.or.jup(nwtot_decl).ne.-99)go to 950
        endif                                                                      
      endif
!
!  The next record contains data  that have dimensions of length, area, or volume converted to cm, cm^2 or cm^3.
!  Before 3/21/2001 this array had 41 elements.   NOTE: Lines marked !TEMP will be deleted the next time it is
!  necessary to change DATE35 in RDRECORD1.
!
      if(numconv.le.0)then                                      !TEMP
        read(35,iostat=iflag,err=990,end=900)convdata(1:41)     !TEMP
        if(kprob.eq.0)then                                      !TEMP
          xorg=0.0d0                                            !TEMP
          yorg=0.0d0                                            !TEMP
        endif                                                   !TEMP
      else                                                      !TEMP
        read(35,iostat=iflag,err=990,end=900)convdata(1:numconv)
      end if                                                    !TEMP
      call ExtractCONVDATA
      kerror=kerrsav
!
!  Check for drive point and if the mesh has zero-area triangles.  The value of RFCODE is true in programs Fish,
!  CFish, Autofish, and the tuning programs.
!
      if(rfcode)then
        if(nspl.eq.0)then
          kerror=211
          if(fopen)then
            write(nout,1500)kerror
1500        format(/'Error',i4/&
            'The problem has no drive point.  Run Automesh again'/&
            'after entering valid coordinates for XDRI,YDRI.')
          endif
          longmsg='The problem has no drive point.  Run'//&
          ' Automesh again after specifying valid coordinates for'//&
          ' (XDRI,YDRI) in the Automesh input file.'
          call TimedMessage(longmsg,MessageTime)
          DrivePointOK=.false.
          return
        else IF(icylin.eq.1.and.ydri.eq.0.0d0)then
          kerror=212
          if(fopen)then
            call FindFmats(xdri,ydri,nsigdigs=6)
            write(nout,1502)kerror,TRIM(ValText(1)),TRIM(ValText(2))
1502        format(/'Error',i4/&
            'Drive point (XDRI,YDRI) = (',a,',',a,') is on a Dirichlet boundary'/&
            'where there is no magnetic field.  Run Automesh again after entering'/&
            'valid coordinates for XDRI,YDRI.')
          endif
          longmsg='The drive point is on a Dirichlet boundary.  Run'//&
          ' Automesh again after specifying valid coordinates for'//&
          ' (XDRI,YDRI) in the Automesh input file.'
          call TimedMessage(longmsg,MessageTime)
          DrivePointOK=.false.
          return
        endif                                                                     
      endif
!
!  The value of POSTPROC is true in programs SFO, SF7, WSFPLOT, FORCE.  Return message and kerror = -13 for WSFPLOT.
!  Don't write the message at this point as it interferes with the child window in WSFPLOT.
!
      if(postproc)then
        if(kprob.eq.1.and.nspl.eq.0)then
          kwarning=186
          if(fopen)then
            write(nout,1503)kwarning
1503        FORMAT(/'Warning',i4/&
            'The problem has no drive point.')
          endif
          longmsg='The problem has no drive point.  You can view the mesh, but the solver codes will not run.'
          IF(lcode.eq.'WSFplot')then
            kerror=-13
          else
            IF(ShowWarning(kwarning).eq.1)then
              call WarningMessage(longmsg,MessageTime)
            endif
            longmsg=' '
          endif
          DrivePointOK=.false.
        endif
        if(negat.gt.0)then
          kwarning=187
          if(fopen)then
            write(nout,1510)kwarning
1510        format(/'Warning',i4/&
            'The mesh has overlapping triangles or zero-area triangles.')
          endif
          longmsg=&
          'The mesh has overlapping or zero-area triangles.  You can view the mesh, but the solver codes will '//&
          'not run.  Look in File OUTAUT.TXT for locations of the bad triangles.'
          IF(lcode.eq.'WSFplot')then
            kerror=-13
          else
            IF(ShowWarning(kwarning).eq.1)then
              call WarningMessage(longmsg,MessageTime)
            endif
            longmsg=' '
          endif
        endif                                                                    
      else if(negat.gt.0)then
        kerror=213
        if(fopen)then
          write(nout,1513)kerror
1513      format(/'Error',i4/&
          'The mesh has overlapping or zero-area triangles.  Look in'/&
          'file OUTAUT.TXT for locations of the bad triangles.')
        endif
        longmsg='The mesh has overlapping or zero-area triangles.  '//TRIM(lcode)//' cannot continue.  Look '//&
        'in File OUTAUT.TXT for locations of the bad triangles.'
        call TimedMessage(longmsg,MessageTime)
        return
      endif
!
!  Read the material and current density data if the caller has supplied the arrays MAT and DEN dimensioned
!  large enough.  All codes currently read this record.
!
      MaterialRecord: if(nareg_decl.ge.nreg)then
        msgstring='MAT and DEN arrays'
        read(35,iostat=iflag,err=990,end=990)(mat(i),den(i),i=0,nreg)
        mat(0)=0
        den(0)=0.0d0                                                      
      else MaterialRecord
        read(35)
      endif MaterialRecord
!
!  Read boundary segment arrays (used in SFO) if NABOUND is dimensioned large enough.  Otherwise, skip this record.
!
      BoundarySegmentRecord: if(nabound_decl.ge.npbound)then
      msgstring='boundary segment arrays'
        read(35,iostat=iflag,err=990,end=990)(nbends(1,i),nbends(2,i),i=1,nseg),(irowbound(i),i=1,npbound)
      else BoundarySegmentRecord
        read(35)
      endif BoundarySegmentRecord
!
!  Read the XX and YY arrays.  This record and the next record are always read.
!
      msgstring='X and Y coordinate arrays'
      read(35,iostat=iflag,err=990,end=990)(xx(i),yy(i),i=1,itot)
!
!  IREGUP and IREGDN are two-byte integers equal to the region numbers of the upper and lower triangles to the
!  right of a point.  They use positive values 1 to 200.  KFILT is a two-byte integer, which for magnet problems
!  may contain region numbers in the same range as IREGUP and IREGDN.  KSKAT and NGO are one-byte integers, but
!  they have a restricted range.  KSKAT is 0 or 1.  NGO is 1, 2, or 3.
!
      msgstring='index and region arrays'
      read(35,iostat=iflag,err=990,end=990)(irlax(i),iregup(i),iregdn(i),kfilt(i),kscat(i),ngo(i),i=1,itot)
!
!  Automesh always writes a real AVECTOR array. Read it into the temporary TVECTOR array.  Check for consistency
!  between the declared value of ICCC and COMPLEXARRAY.  Overwrite the CON setting with the declared setting.
!  Note: Errors 214 and 215 generally cannot occur when called from standard postprocessors or from the Interp DLL.
!
      iccc=iccc_decl
      IF(complexarray)then
        if(iccc.ne.2)then
          kerror=214
          if(fopen)then
            write(nout,1520)kerror,'COMPLEX','REAL'
1520        format(/'Error',i4/&
            'Subroutine RDTAPE35 expects to return a ',a,' solution'/&
            'array, but the calling program expects a ',a,' array.')
            WRITE(nout,12130)
          endif
          write(longmsg,15201)'COMPLEX','REAL'
15201     format('The RDTAPE35 subroutine is configured to return a ',a,&
          ' solution array, but the calling program expects a ',a,' array.')
          longmsg=TRIM(longmsg)//ReportThisError
          call TimedMessage(longmsg,MessageTime)
          return
        endif
        if(allocated(tvector))deallocate(tvector)
        allocate(tvector(itot))
        read(35,iostat=iflag,err=990,end=990)(tvector(i),i=1,itot)
        avector=cmplx(tvector,0.0d0,8)
        i=0    ! useful stopping point for debugging
      else
        if(iccc.ne.1)then
          kerror=215
          if(fopen)then
            write(nout,1520)kerror,'REAL','COMPLEX'
            WRITE(nout,12130)
          endif
          write(longmsg,15201)'REAL','COMPLEX'
          longmsg=TRIM(longmsg)//ReportThisError
          call TimedMessage(longmsg,MessageTime)
          return
        endif
        read(35,iostat=iflag,err=990,end=990)(avector(i),i=1,itot)
      endif
      if(itot2_decl.ge.itot)then
        source=avector
      endif
!
!  For Poisson and Pandira problems, the next record contains the array IRLAXP, which may have a different
!  mesh-point order than in IRLAX.  For Pandira only, read the IRLAXP array into the IRLAX array over-writing
!  the original IRLAX.  Skip this record in other magnet codes.
!
      ProblemType: if(kprob.eq.0)then  ! Poisson
        if(maincode.eq.'PANDIRA')then
          msgstring='Pandira relaxation-order'
          read(35,iostat=iflag,err=990,end=990)(irlax(i),i=1,itot)
        else
          read(35)
        endif                                                           
!
!  If the coupling arrays exist in TAPE35, NWMAX is their length.  Read the coupling arrays if the caller
!  supplied large enough arrays JNDEX and JUP.
!
        if(nwmax.gt.0)then
          if(nwtot_decl.ge.nwmax)then
            msgstring='coupling arrays'
            read(35,iostat=iflag,err=990,end=990)(jndex(i),jup(i),i=1,nwmax)
          else
            read(35)
          endif                                                             
        endif
!
!  Read fixed-potential boundary point information (used in WSFplot and CFish).  This data exists only for
!  Superfish problem with multiple drive points.
!
      else if(kprob.eq.1)then ProblemType  ! Superfish
        MultipleDriveRecord: if(nspl.gt.1)then
          if(nbspl_decl.ge.nspl)then
            read(35,iostat=iflag,err=990,end=990)(nbdrive(n),n=1,nspl),(avecini(n),n=1,nspl)
!
!  If a complex potential is also being returned, set the imaginary part.
!
            if(complexarray)then
              do n=1,nspl
                irow=nbdrive(n)
                rpart=dble(avector(irow))
                avector(irow)=cmplx(rpart,avecini(n),8)
              enddo
            endif                                          
!
!  Skip this record if the arrays were not supplied.
!
          else
            read(35)
          endif
!
!  Write a warning message if Fish is attempting to run on a problem with initialized complex fields.
!
          if((maincode.eq.'FISH'.or.maincode.eq.'AUTOFISH').and.iccc.eq.2)then
            kwarning=188
            if(fopen)then
              write(nout,2000)kwarning
2000          format(/'Warning',i4/&
              'This problem contains initialized fixed-potential boundary points'/&
              'with complex fields.  Fish uses only the real part.  Run CFish'/&
              'instead to include the effects of the imaginary part of the fields.')
            endif
            longmsg='This problem contains initialized fixed-potential boundary points'//&
            ' with complex fields.  Fish uses only the real part.  Run CFish instead if you'//&
            ' want to include the effects of the imaginary part of the fields.'
            IF(ShowWarning(kwarning).eq.1)then
              call WarningMessage(longmsg,MessageTime)
            endif
          endif
        endif MultipleDriveRecord
!
!  Read tuning-code setup arrays.  For Superfish problems, SFO writes this data in the .SFO file for use by SFOTABLE.
!
        if(infodata.gt.0)then
          if(infosize_decl.ge.infodata)then
            msgstring='tuning-code setup arrays'
            read(35,iostat=iflag,err=990,end=990)(tpvalue(n),n=1,infodata),(tpname(n),n=1,infodata)
          else
            read(35)
          endif
        endif                                                                  
      endif ProblemType
!
!  Read the material data.
!
      msgstring='material-table arrays'
      ReadMaterials: if(kprob.eq.0)then
        read(35,iostat=iflag,err=990,end=990)(aeasymt(i),gampermt(i),x0amt(i),y0amt(i),phiamt(i),amultmt(i),&
        hceptmt(i),bceptmt(i),gammamt(i),mtlength(i),mtypemt(i),i=1,maxtable),(stacki(i),mattbli(i),mshapemt(i),&
        i=0,maxmat)
        do j=1,maxtable
          if(mtlength(j).gt.0)then
            write(msgstring,2200)j
2200        format('material table',i3)
            read(35,iostat=iflag,err=990,end=990)(bt(i,j),gt(i,j),i=1,mtlength(j))
          endif
        enddo
!
      else if(kprob.eq.1.and.nmatr.gt.0)then ReadMaterials
        read(35,iostat=iflag,err=990,end=990)(epsmt(i),fmumt(i),i=1,maxtable)
      endif ReadMaterials
!
!  Stop here for solver codes.
!
      if(.not.postproc)then
        return
      endif
!
!  Read the solution records, which contains these records:
!  Superfish             Poisson
!  CON arrays            CON arrays
!  AVECTOR               AVECTOR
!                        SOURCE,GTU,GTL
!
      msgstring='problem variable array'
      select case (Record1Type)
        case (0)
          read(35,err=990,end=910)(con(i),icon(i),namep(i),i=1,ncon),ntitle,title,originatingcode,probtype,&
          probfile,probdate,iprobsize
        case (1)
          read(35,err=990,end=910)(con(i),icon(i),namep(i),i=1,ncon),ntitle,title,originatingcode,probtype,&
          probfile64,probdate,iprobsize
        case (2)
          read(35,err=990,end=910)(con(i),icon(i),namep(i),i=1,ncon),ntitle,title,originatingcode,probtype,&
          probfile64,oldprobdate,iprobsize
      end select
      kprob=icon(1)
      call ExtractCONarray
!  Before 3/21/2001 this array had 41 elements.   NOTE: Lines marked !TEMP will be deleted the next time it is
!  necessary to change DATE35 in RDRECORD1.
      if(numconv.le.0)then                                      !TEMP
        read(35,iostat=iflag,err=990,end=900)convdata(1:41)     !TEMP
        if(kprob.eq.0)then                                      !TEMP
          xorg=0.0d0                                            !TEMP
          yorg=0.0d0                                            !TEMP
        endif                                                   !TEMP
      else                                                      !TEMP
        read(35,iostat=iflag,err=990,end=900)convdata(1:numconv)
      end if                                                    !TEMP
      call ExtractCONVDATA
!
!  ICCC will equal 2 if the array in TAPE35 is complex.  In this case, CVECTOR must be available to continue.
!
      AVECTORdata: if(iccc.eq.2)then
        msgstring='complex AVECTOR array'
        read(35,iostat=iflag,err=990,end=980)(avector(i),i=1,itot)
!
!  If ICCC is 1, then the array in TAPE35 is real.  At least one of the arrays CVECTOR or RVECTOR must be
!  available to hold the data.
!
      else if(iccc.eq.1)then AVECTORdata
        msgstring='real AVECTOR array'
!
!  Read the data into either the RVECTOR array or the SOURCE array, or, if necessary, the TVECTOR array that
!  was allocated earlier.
!
        if(complexarray)then
          if(.not.allocated(tvector))allocate(tvector(itot))
          read(35,iostat=iflag,err=990,end=980)(tvector(i),i=1,itot)
          avector=cmplx(tvector,0.0d0,8)
        else
          read(35,iostat=iflag,err=990,end=980)(avector(i),i=1,itot)
        endif
      endif AVECTORdata
!
!  For magnet problems, the next record contains the SOURCE array and the reluctivity arrays.  The caller can
!  request only the SOURCE by not providing the GTU and GTL arrays.  WSFplot and SF7 use the SOURCE array, but
!  not the reluctivity arrays.  FORCE reads all three.
!
      Poissondata: if(kprob.eq.0)then
        if(itot2_decl.ge.itot.and.itot3_decl.ge.itot)then
          msgstring='source and reluctivity arrays'
          read(35,iostat=iflag,err=990,end=980)(source(i),gtu(i),gtl(i),i=1,itot)
        else if(itot2_decl.ge.itot)then
          msgstring='source array'
          read(35,iostat=iflag,err=990,end=980)(source(i),gtu(1),gtl(1),i=1,itot)
        else
          read(35)
        endif
      endif Poissondata
      IF(kerror.NE.-13.and.longmsg.ne.' ')then
        call TimedMessage(longmsg,MessageTime)
      endif
      T35SolutionRead=.true.
      return
900   kerror=216
      if(fopen)then
        write(nout,90001)kerror,trim(T35File)
90001   format(/'Error',i4/&
        'Unable to read triangular mesh data from file ',a,'.'/&
        'Run Automesh to generate a new mesh.')
      endif
      longmsg='Unable to read triangular mesh data from file '//trim(T35File)//&
      '.  Run Automesh to generate a new mesh.'
      call TimedMessage(longmsg,MessageTime)
      return
910   IF(maincode.eq.'WSFPLOT')then
        kerror=0
        return
      else IF(kprob.eq.1)then
        kerror=217
        if(fopen)then
          write(nout,91001)kerror,trim(T35File)
91001     format(/'Error',i4/&
          'File ',a,' does not contain a solution array.'/&
          'Run Fish or CFish to compute the solution.')
        endif
        longmsg='File '//trim(T35File)//' does not contain a solution'//&
        ' array.  Run Fish or CFish to compute the solution.'
      else
        kerror=218
        if(fopen)then
          write(nout,91002)kerror,trim(T35File)
91002     format(/'Error',i4/&
          'File ',a,' does not contain a solution array.'/&
          'Run Poisson or Pandira to compute the solution.')
        endif
        longmsg='File '//trim(T35File)//' does not contain a solution'//&
        ' array.  Run Poisson or Pandira to compute the solution.'
      endif
      call TimedMessage(longmsg,MessageTime)
      return
!
!  Message for errors reading AVECTOR array.
!
940   kerror=209
      if(fopen)then
        write(nout,9400)kerror,trim(msgstring)
9400    format(/'Error',i4/&
        'The dimension of array ',a,' is not large enough.')
        WRITE(nout,12130)
      endif
      longmsg='The dimension of array '//trim(msgstring)//' is not large enough.'//ReportThisError
      IF(maincode.eq.'WSFPLOT')return
      call TimedMessage(longmsg,MessageTime)
      return
950   kerror=208
      if(fopen)then
        write(nout,9500)kerror,trim(msgstring)
9500    format(/'Error',i4/&
        'Array ',a,' has not been properly declared.')
        WRITE(nout,12130)
      endif
      longmsg='Array '//trim(msgstring)//' has not been properly declared.'//ReportThisError
      IF(maincode.eq.'WSFPLOT')return
      call TimedMessage(longmsg,MessageTime)
      return
980   kerror=220
      if(fopen)then
        write(nout,98001)kerror,trim(T35File),trim(msgstring)
98001   format(/'Error',i4/&
        'Reached the end of file ',a,' unexpectedly while reading ',a,'.')
      endif
      longmsg='The program has reached the end of file '//&
      trim(T35File)//' unexpectedly while reading '//trim(msgstring)//'.'
      IF(maincode.eq.'WSFPLOT')return
      call TimedMessage(longmsg,MessageTime)
      return
!
!  Message for errors reading an array.
!
990   kerror=221
      if(fopen)then
        write(nout,99001)kerror,trim(msgstring),trim(T35File),TRIM(ichn(iflag))
99001   format(/'Error',i4/&
        'Cannot read ',a,' from file ',a,'.  IOSTAT =',a)
        WRITE(nout,12130)
      endif
      longmsg='An error has occurred reading '//trim(msgstring)//' in file '//trim(T35File)//'.'//ReportThisError
      IF(maincode.eq.'WSFPLOT')return
      call TimedMessage(longmsg,MessageTime)
      return
      end subroutine

