import numpy as np
import os

sf_automesh = r"C:\LANL\automesh.exe"
sf_autofish = r"C:\LANL\autofish.exe"
sf_poisson = r"C:\LANL\poisson.exe"
sf_wsfplot = r"C:\LANL\wsfplot.exe"

name = "3EPSILON"
os.system("{} {}".format(sf_automesh, name + ".am"))
os.system("{} {}".format(sf_poisson, name + ".t35"))
os.system("{} {}".format(sf_wsfplot, name + ".t35"))
