START /W  " "  "%SFDIR%automesh"   pmdipole
START /W  " "  "%SFDIR%pandira"    pmdipole
START /W  " "  "%SFDIR%SF7"        pmdipole
copy outaut.txt outaut1.txt
copy outpan.txt outpan1.txt
START /W  " "  "%SFDIR%WSFplot"  pmdipole.t35 3
START /W  " "  "%SFDIR%Tablplot" pmdipo2.tbl 3

START /W  " "  "%SFDIR%automesh"   pmdvar
START /W  " "  "%SFDIR%pandira"    pmdvar
START /W  " "  "%SFDIR%WSFplot" pmvar.t35 3

