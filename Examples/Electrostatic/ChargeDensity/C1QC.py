import numpy as np
import matplotlib.pyplot as plt
import sys
import os
import time
import shutil
import subprocess
import pyautogui as pgui
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

    name = "C1QC"
    sfdir = os.environ["SFDIR"]
    subprocess.Popen("{0:}{1:} {2:}".format(sfdir, "WSFPLOT", name),
                    shell=True, stdin=None, stdout=None, stderr=None, close_fds=True)
    # pgui.press("C")
