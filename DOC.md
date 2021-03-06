---
title: LANL doc
---

## sftoc

This file, containing the table of contents and suggestions for viewing and printing.

## SFPOSTP

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

## SFFILES

Brief descriptions of all the input and output files used in the Poisson Superfish codes.

## SFINTRO

General information about the software installation, features in the codes, references, history, SF.INI configuration, and technical support.

## SFCODES1

Information about the main programs Autofish, Automesh, Fish, CFish, Poisson, and Pandira.

```bash
AUTOFISH AM.file
```

## SFCODES2

The automated tuning programs CCLfish, CDTfish, DTLfish, MDTfish, ELLfish, and RFQfish.

## SFCODES3

General purpose plotting programs Quikplot and Tablplot, and utility programs Beta, Kilpat, List35, ConvertF, SF8, FScale, SegField, and SFOtable.

## SFEXMPL1 - rf-field example

Discussion of rf-field example files for Fish, CFish, and Autofish contained in the Examples\RadioFrequency subdirectories

## SFEXMPL2 - static-field example

Discussion of the static-field example files for Poisson and Pandira contained in the Examples\Magnetostatic and Examples\Electrostatic subdirectories

## SFEXMPL3 - tuning-program

Discussion of the tuning-program example files contained in the Examples\CavityTuning subdirectories.

## SFPHYS1 - Theory of electrostatics and magnetostatics

Theory of electrostatics and magnetostatics from John Warren’s treatment in the 1987 Reference Manual

## SFPHYS2 - Properties of static magnetic and electric fields

Properties of static magnetic and electric fields from John Warren’s treatment in the 1987 Reference Manual

## SFPHYS3

Boundary conditions and symmetriesfrom John Warren’s treatment in the 1987 Reference Manual

## SFPHYS4

Numerical methods in Poisson and Pandirafrom John Warren’s treatment in the 1987 Reference Manual

## SFPHYS5 - RF cavity theoryfrom

RF cavity theoryfrom John Warren’s treatment in the 1987 Reference Manual
