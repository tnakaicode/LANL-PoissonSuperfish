start /W  " "  "%SFDIR%automesh"  wr2300
start /W  " "  "%SFDIR%autofish"     wr2300
copy outaut.txt outaut1.txt
copy outfis.txt outfis1.txt
start /W  " "  "%SFDIR%WSFplot" wr2300.t35 3

start /W  " "  "%SFDIR%automesh"  wghex
start /W  " "  "%SFDIR%autofish"     wghex
copy outaut.txt outaut2.txt
copy outfis.txt outfis2.txt
start /W  " "  "%SFDIR%WSFplot" wghex.t35 3

