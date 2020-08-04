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
    parser.add_option("--pxyz", dest="pxyz",
                      default=[0.0, 0.0, 0.0], type="float", nargs=3)
    opt, argc = parser.parse_args(argvs)
    print(opt, argc)

    name = "VECP"
    sfdir = "e:/LANL/"
    shutil.copyfile("SF.INI", sfdir + "SF.INI")
    subprocess.call("{0:}{1:} {2:}".format(sfdir, "AUTOMESH", name + ".am"))
    subprocess.call("{0:}{1:} {2:}".format(sfdir, "POISSON", name + ".t35"))
    subprocess.Popen("{0:}{1:} {2:}".format(sfdir, "WSFPLOT", name + ".t35"))
    subprocess.Popen("{0:}{1:} {2:}".format(sfdir, "SF7", name + ".t35"))
    shutil.copyfile("../../../SF.INI", sfdir + "SF.INI")
    # pgui.press("c")

    #data = np.loadtxt("./3EPSILON.txt", skiprows=2)
    # plt.figure()
    #plt.plot(data[2,:], data[4,:])
    # plt.savefig("./3EPSILON.png")
