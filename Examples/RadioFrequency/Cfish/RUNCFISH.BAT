start /W  " "  "%SFDIR%automesh"  dirod
start /W  " "  "%SFDIR%autofish"     dirod
copy outaut.txt outaut1.txt
copy outfis.txt outfis1.txt
start /W  " "  "%SFDIR%WSFplot" dirod.t35 3

start /W  " "  "%SFDIR%automesh"  coaxwg
start /W  " "  "%SFDIR%autofish"     coaxwg
start /W  " "  "%SFDIR%SFO"       coaxwg
start /W  " "  "%SFDIR%SF7"       coaxwg
copy outaut.txt outaut2.txt
copy outfis.txt outfis2.txt
start /W  " "  "%SFDIR%WSFplot" coaxwg.t35 3

start /W  " "  "%SFDIR%automesh"  splitter
start /W  " "  "%SFDIR%autofish"     splitter
copy outaut.txt outaut3.txt
copy outfis.txt outfis3.txt
start /W  " "  "%SFDIR%WSFplot" splitter.t35 3

start /W  " "  "%SFDIR%automesh"  qztube
start /W  " "  "%SFDIR%autofish"     qztube
start /W  " "  "%SFDIR%SFO"       qztube
start /W  " "  "%SFDIR%SF7"       qztube
start /W  " "  "%SFDIR%WSFplot" qztube.t35 3
