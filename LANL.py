import numpy as np
import os
import sys
import time
import subprocess
from linecache import getline, clearcache
from optparse import OptionParser


if __name__ == '__main__':
    argvs = sys.argv
    parser = OptionParser()
    parser.add_option("--dir", dest="dir", default="./")
    parser.add_option("--inp", dest="inp", default="./dealii-33/slide.inp")
    parser.add_option("--pxyz", dest="pxyz",
                      default=[0.0, 0.0, 0.0], type="float", nargs=3)
    opt, argc = parser.parse_args(argvs)
    print(opt, argc)

    print(os.environ["SFDIR"])

    #
    # %SFDIR%autofish file
    # %SFDIR%automesh file
    # %SFDIR%automesh file
    # %SFDIR%Tablplot file.tbl sec
    # %SFDIR%Tablplot file.tbl sec
    # %SFDIR%WSFplot  file.t35 sec
    #

    # %SFDIR%AUTOFISH.EXE
    # %SFDIR%AUTOMESH.EXE
    # %SFDIR%beta.exe
    # %SFDIR%CCLCELLS.EXE
    # %SFDIR%CCLFISH.EXE
    # %SFDIR%CDTFISH.EXE
    # %SFDIR%CFISH.EXE
    # %SFDIR%CONVERTF.EXE
    # %SFDIR%DTLCELLS.EXE
    # %SFDIR%DTLFISH.EXE
    # %SFDIR%ELLCAV.EXE
    # %SFDIR%ELLFISH.EXE
    # %SFDIR%FISH.EXE
    # %SFDIR%FORCE.EXE
    # %SFDIR%FSCALE.EXE
    # %SFDIR%KILPAT.EXE
    # %SFDIR%LIST35.EXE
    # %SFDIR%MDTCELLS.EXE
    # %SFDIR%MDTFISH.EXE
    # %SFDIR%MK_SFINI.EXE
    # %SFDIR%PANDIRA.EXE
    # %SFDIR%POISSON.EXE
    # %SFDIR%Quikplot.exe
    # %SFDIR%RFQFISH.EXE
    # %SFDIR%SCCFISH.EXE
    # %SFDIR%SEGFIELD.EXE
    # %SFDIR%SF7.EXE
    # %SFDIR%SF8.EXE
    # %SFDIR%SFO.EXE
    # %SFDIR%SFOTABLE.EXE
    # %SFDIR%Tablplot.exe
    # %SFDIR%wsfcolor.exe
    # %SFDIR%WSFPLOT.EXE
    #
