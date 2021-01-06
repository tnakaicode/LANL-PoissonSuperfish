Rem  File Run_TC.BAT runs Poisson Superfish tuning programs  
Rem  in each of the CavityTuning subdirectories.  Run from
Rem  a Windows tool  such as My Computer.  Running from DOS
Rem  windows will not work because of long filenames.

Rem  Copyright 1998, by the University of California. 
Rem  Unauthorized commercial use is prohibited. 

Rem  Remove "Rem" from the next line to prevent codes from opening display windows.   
Rem set screenoutput=no

cd "CavityTuning\CCDTL"
START /W  " "  "%SFDIR%cdtfish" 1dtfc
START /W  " "  "%SFDIR%cdtfish" 2dthc


cd "CavityTuning\CCL"
START /W  " "  "%SFDIR%cclfish" 805ccl
START /W  " "  "%SFDIR%cclfish" 805er
START /W  " "  "%SFDIR%cclfish" 805wr
START /W  " "  "%SFDIR%cclfish" 3ghz
START /W  " "  "%SFDIR%cclfish" 425ew


cd "CavityTuning\DTL"
START /W  " "  "%SFDIR%dtlfish"  dtltest
START /W  " "  "%SFDIR%dtlfish"  rgfish
START /W  " "  "%SFDIR%sfotable" rgdtl.sft


cd "CavityTuning\EllipticalCavity"
START /W  " "  "%SFDIR%ellfish"  82b
START /W  " "  "%SFDIR%ellfish"  82be
START /W  " "  "%SFDIR%ellcav"   82be00
START /W  " "  "%SFDIR%autofish" 8c82be1
START /W  " "  "%SFDIR%sfo"      8c82be1.seg
START /W  " "  "%SFDIR%segfield" segfld.sgf


cd "CavityTuning\MulticellDTL"
START /W  " "  "%SFDIR%mdtfish" mdttest


cd "CavityTuning\RFQ"
START /W  " "  "%SFDIR%rfqfish" rfqtest
START /W  " "  "%SFDIR%rfqfish" lansce


cd "CavityTuning\SideCouplingCell"
START /W  " "  "%SFDIR%sccfish" 805cc
START /W  " "  "%SFDIR%sccfish" lf


cd "CavityTuning"
