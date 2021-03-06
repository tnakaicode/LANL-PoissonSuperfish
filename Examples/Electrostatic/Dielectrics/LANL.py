import numpy as np
import matplotlib.pyplot as plt
import sys
import os
import time
import shutil
import subprocess
import pyautogui as pgui
from optparse import OptionParser

import logging
logging.getLogger('matplotlib').setLevel(logging.ERROR)


if __name__ == '__main__':
    argvs = sys.argv
    parser = OptionParser()
    parser.add_option("--dir", dest="dir", default="./")
    parser.add_option("--name", dest="name", default="3EPSILON")
    parser.add_option("--pxyz", dest="pxyz",
                      default=[0.0, 0.0, 0.0], type="float", nargs=3)
    opt, argc = parser.parse_args(argvs)
    print(opt, argc)

    print(os.environ["SFDIR"])

    name = opt.name
    sfdir = os.environ["SFDIR"]
    #shutil.copyfile("SF.INI", sfdir + "SF.INI")
    subprocess.call("{0:}{1:} {2:}".format(sfdir, "AUTOMESH", name + ".am"))
    subprocess.call("{0:}{1:} {2:}".format(sfdir, "POISSON", name + ".t35"))
    subprocess.call("{0:}{1:} {2:} 3".format(sfdir, "WSFPLOT", name + ".t35"))
    #subprocess.Popen("{0:}{1:} {2:}".format(sfdir, "SF7", name + ".t35"))
    #shutil.copyfile("../../../SF.INI", sfdir + "SF.INI")
    # pgui.press("c")

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
