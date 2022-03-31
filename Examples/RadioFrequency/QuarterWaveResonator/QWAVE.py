import numpy as np
import matplotlib.pyplot as plt
import sys
import os
import time
import shutil
import subprocess
import argparse

import logging
logging.getLogger('matplotlib').setLevel(logging.ERROR)

if __name__ == '__main__':
    argvs = sys.argv
    parser = argparse.ArgumentParser()
    parser.add_argument("--dir", dest="dir", default="./")
    parser.add_argument("--pxyz", dest="pxyz",
                      default=[0.0, 0.0, 0.0], type=float, nargs=3)
    opt = parser.parse_args()
    print(opt, argvs)

    name = "QWAVE"
    sfdir = "D:/LANL/"
    shutil.copyfile("SF.INI", sfdir + "SF.INI")
    subprocess.call("{0:}{1:} {2:}".format(sfdir, "AUTOFISH", name + ".af"))
    subprocess.Popen("{0:}{1:} {2:}".format(sfdir, "WSFPLOT", name + ".t35"))
    subprocess.Popen("{0:}{1:} {2:}".format(sfdir, "SF7", name + ".t35"))
    shutil.copyfile("../../../SF.INI", sfdir + "SF.INI")
    # pgui.press("c")

    #data = np.loadtxt("./3EPSILON.txt", skiprows=2)
    # plt.figure()
    #plt.plot(data[2,:], data[4,:])
    # plt.savefig("./3EPSILON.png")
