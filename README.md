# README

<https://123deta.com/document/oy8gn54z-poisson-superfish-manual.html>

- Autmesh
  - Generate optimized meshes according to material and shape
  - 材料と形状に応じて最適化されたメッシュを生成
  - *.am -> *.t35
- Poisson
  - Find the magnetic field. Find vector potential on grid points of mesh generated by Automesh
  - 磁場を求める。Automeshで生成したメッシュの格子点上のベクトルポテンシャルを求める
  - *.t35 -> *.t35(add)
  - There is another calculation method Pandira. You can calculate permanent magnets.
  - 別の計算方法のPandiraがある。永久磁石の計算ができる。
- WSFplot
  - Plot Automesh, Poisson results
  - $A_z$ in rectangular coordinate system, $r A_{\phi}$ in cylindrical coordinate system by default
- SF7
  - Complement the result calculated by Poisson on the route specified by the user
  - Use when plotting the magnetic field on the path with Tablplot
  - Poissonが計算した結果をユーザー指定の経路上で補完する
  - 経路上の磁場をTablplotでプロットする際に使う
  - *.in7
- Tablplot
  - Plot row / column data
  - *.tbl

| doc                 | Des                                                                 |
| ------------------- | ------------------------------------------------------------------- |
| ./Docs/SFCODES.DOC  | Autofish, Automesh, Fish, CFish, Poisson, Pandira                   |
| ./Docs/SFCODES2.DOC | Cavity tuning programs XXXfish (CCLfish, DTLfish, etc.)             |
| ./Docs/SFCODES3.DOC | Plotting programs Quikplot, Tablplot, and utility programs          |
| ./Docs/SFEXMPL1.DOC | Example files for Fish, CFish, and Autofish                         |
| ./Docs/SFEXMPL2.DOC | Example files for Poisson and Pandira                               |
| ./Docs/SFEXMPL3.DOC | Example files for tuning programs                                   |
| ./Docs/SFFILES.DOC  | Descriptions of input and output files                              |
| ./Docs/SFINTRO.DOC  | Introduction, problem variables, SF.INI settings, technical support |
| ./Docs/SFPHYS1.DOC  | Theory of electrostatics and magnetostatics                         |
| ./Docs/SFPHYS2.DOC  | Properties of static magnetic and electric fields                   |
| ./Docs/SFPHYS3.DOC  | Boundary conditions and symmetries                                  |
| ./Docs/SFPHYS4.DOC  | Numerical methods in Poisson and Pandira                            |
| ./Docs/SFPHYS5.DOC  | RF cavity theory                                                    |
| ./Docs/SFPOSTP.DOC  | WSFplot, SFO, SF7, Force                                            |
