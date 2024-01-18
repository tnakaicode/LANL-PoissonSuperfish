import numpy as np
import matplotlib.pyplot as plt
import sys
import os
import time
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

    name = "3EPSILON"
    sfdir = os.environ["SFDIR"]
    subprocess.call("{0:}{1:} {2:}".format(sfdir, "AUTOMESH", name + ".am"))
    subprocess.call("{0:}{1:} {2:}".format(sfdir, "POISSON", name + ".t35"))
    subprocess.call("{0:}{1:} {2:}".format(sfdir, "WSFPLOT", name + ".t35"))
    # pgui.press("c")

    #data = np.loadtxt("./3EPSILON.txt", skiprows=2)
    # plt.figure()
    #plt.plot(data[:, 2], data[:, 6])
    # plt.savefig("./3EPSILON.png")
