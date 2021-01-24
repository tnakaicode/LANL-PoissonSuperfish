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

    name = "C4QPNT"
    sfdir = os.environ["SFDIR"]
    subprocess.Popen("{0:}{1:} {2:}".format(sfdir, "AUTOMESH", name),
                    shell=True, stdin=None, stdout=None, stderr=None, close_fds=True)
    subprocess.Popen("{0:}{1:} {2:}".format(sfdir, "POISSON", name),
                    shell=True, stdin=None, stdout=None, stderr=None, close_fds=True)
    subprocess.Popen("{0:}{1:} {2:}".format(sfdir, "PANDIRA", name),
                    shell=True, stdin=None, stdout=None, stderr=None, close_fds=True)
    subprocess.Popen("{0:}{1:} {2:}".format(sfdir, "WSFPLOT", name),
                    shell=True, stdin=None, stdout=None, stderr=None, close_fds=True)
    # pgui.press("C")
