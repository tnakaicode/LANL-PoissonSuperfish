START /W  " "  "%SFDIR%automesh"  3epsilon
START /W  " "  "%SFDIR%poisson"   3epsilon
copy outaut.txt outaut3.txt
copy outpoi.txt outpoi3.txt
START /W  " "  "%SFDIR%WSFplot" 3epsilon.t35
