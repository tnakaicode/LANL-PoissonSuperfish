---
title: LANL doc
---

- [1. sftoc](#1-sftoc)
- [2. SFPOSTP](#2-sfpostp)
- [3. SFFILES](#3-sffiles)
- [4. SFINTRO](#4-sfintro)
- [5. SFCODES1](#5-sfcodes1)
  - [5.1. Autofish: Combined Automesh, Fish, and SFO](#51-autofish-combined-automesh-fish-and-sfo)
  - [5.2. Automesh: the Poisson Superfish Mesh Generator](#52-automesh-the-poisson-superfish-mesh-generator)
  - [5.3. Fish and CFish, Radio-Frequency Field Solvers](#53-fish-and-cfish-radio-frequency-field-solvers)
  - [5.4. Poisson and Pandira, Static Field Solvers](#54-poisson-and-pandira-static-field-solvers)
- [6. SFCODES2 - Automated Tuning Programs](#6-sfcodes2---automated-tuning-programs)
- [7. SFCODES3](#7-sfcodes3)
  - [7.1. Plotting Programs Quikplot and Tablplot](#71-plotting-programs-quikplot-and-tablplot)
  - [7.2. Utility Programs](#72-utility-programs)
- [8. SFEXMPL1 - rf-field example](#8-sfexmpl1---rf-field-example)
- [9. SFEXMPL2 - static-field example](#9-sfexmpl2---static-field-example)
  - [9.1. Magnetostatic Examples (Poisson, Pandira)](#91-magnetostatic-examples-poisson-pandira)
  - [9.2. Electrostatic Examples (Poisson, Pandira)](#92-electrostatic-examples-poisson-pandira)
- [10. SFEXMPL3 - tuning-program](#10-sfexmpl3---tuning-program)
- [11. SFPHYS1 - Theory of electrostatics and magnetostatics](#11-sfphys1---theory-of-electrostatics-and-magnetostatics)
- [12. SFPHYS2 - Properties of static magnetic and electric fields](#12-sfphys2---properties-of-static-magnetic-and-electric-fields)
- [13. SFPHYS3 - Boundary Conditions and Symmetries](#13-sfphys3---boundary-conditions-and-symmetries)
- [14. SFPHYS4 - Numerical Methods in Poisson and Pandira](#14-sfphys4---numerical-methods-in-poisson-and-pandira)
- [15. SFPHYS5 - RF cavity theoryfrom](#15-sfphys5---rf-cavity-theoryfrom)

## 1. sftoc

This file, containing the table of contents and suggestions for viewing and printing.

## 2. SFPOSTP

Information about the postprocessor programs WSFplot, SFO, SF7, and Force.

```bash
WSFplot time T35.file

[WSFplot]
WriteFieldContours = Yes
OUTWSF.TXT

# Poisson Superfish Postprocessor
SFO SEG.file T35.file
SF7 IN7.file T35.file
FORCE FORCE.file T35.file
```

- SFO Peak magnetic and electric fields and the Kilpatrick factor
- SF7 EGUN keyword to create input for program EGUN

## 3. SFFILES

Brief descriptions of all the input and output files used in the Poisson Superfish codes.

## 4. SFINTRO

General information about the software installation, features in the codes, references, history, SF.INI configuration, and technical support.

## 5. SFCODES1

Information about the main programs Autofish, Automesh, Fish, CFish, Poisson, and Pandira.

```bash
AUTOFISH AM.file
```

### 5.1. Autofish: Combined Automesh, Fish, and SFO

### 5.2. Automesh: the Poisson Superfish Mesh Generator

### 5.3. Fish and CFish, Radio-Frequency Field Solvers

### 5.4. Poisson and Pandira, Static Field Solvers

## 6. SFCODES2 - Automated Tuning Programs

The automated tuning programs CCLfish, CDTfish, DTLfish, MDTfish, ELLfish, and RFQfish.

## 7. SFCODES3

General purpose plotting programs Quikplot and Tablplot, and utility programs Beta, Kilpat, List35, ConvertF, SF8, FScale, SegField, and SFOtable.

### 7.1. Plotting Programs Quikplot and Tablplot

### 7.2. Utility Programs

## 8. SFEXMPL1 - rf-field example

Discussion of rf-field example files for Fish, CFish, and Autofish contained in the Examples\RadioFrequency subdirectories

## 9. SFEXMPL2 - static-field example

Discussion of the static-field example files for Poisson and Pandira contained in the Examples\Magnetostatic and Examples\Electrostatic subdirectories

### 9.1. Magnetostatic Examples (Poisson, Pandira)

### 9.2. Electrostatic Examples (Poisson, Pandira)

## 10. SFEXMPL3 - tuning-program

Discussion of the tuning-program example files contained in the Examples\CavityTuning subdirectories.

## 11. SFPHYS1 - Theory of electrostatics and magnetostatics

Theory of electrostatics and magnetostatics from John Warren’s treatment in the 1987 Reference Manual

## 12. SFPHYS2 - Properties of static magnetic and electric fields

Properties of static magnetic and electric fields from John Warren’s treatment in the 1987 Reference Manual

## 13. SFPHYS3 - Boundary Conditions and Symmetries

Boundary conditions and symmetriesfrom John Warren’s treatment in the 1987 Reference Manual

## 14. SFPHYS4 - Numerical Methods in Poisson and Pandira

Numerical methods in Poisson and Pandirafrom John Warren’s treatment in the 1987 Reference Manual

## 15. SFPHYS5 - RF cavity theoryfrom

RF cavity theoryfrom John Warren’s treatment in the 1987 Reference Manual
