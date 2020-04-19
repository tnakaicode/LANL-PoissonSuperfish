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

Document  
| doc          | Des                                                                 |
| :----------- | ------------------------------------------------------------------- |
| SFINTRO.pdf  | Introduction, problem variables, SF.INI settings, technical support |
| SFCODES1.pdf | Autofish, Automesh, Fish, CFish, Poisson, Pandira                   |
| SFCODES2.pdf | Cavity tuning programs XXXfish (CCLfish, DTLfish, etc.)             |
| SFCODES3.pdf | Plotting programs Quikplot, Tablplot, and utility programs          |
| SFPOSTP.pdf  | WSFplot, SFO, SF7, Force                                            |
| SFFILES.pdf  | Descriptions of input and output files                              |
| SFEXMPL1.pdf | Example files for Fish, CFish, and Autofish                         |
| SFEXMPL2.pdf | Example files for Poisson and Pandira                               |
| SFEXMPL3.pdf | Example files for tuning programs                                   |
| SFPHYS1.pdf  | Theory of electrostatics and magnetostatics                         |
| SFPHYS2.pdf  | Properties of static magnetic and electric fields                   |
| SFPHYS3.pdf  | Boundary conditions and symmetries                                  |
| SFPHYS4.pdf  | Numerical methods in Poisson and Pandira                            |
| SFPHYS5.pdf  | RF cavity theory                                                    |

SF.INI  
| Keyword              | Desc                                                                                                                   |
| -------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| AlwaysBrowse         | Always browse for a binary solution file.                                                                              |
| ArcAndLineSteps      | Default number of steps in SF7 for interpolation on lines and arcs.                                                    |
| ArcRadius            | Default arc radius in SF7 for interpolation on arcs.                                                                   |
| ArrowKeyStepSize     | ]Cursor step size in WSFplot as a percentage of the screen width.                                                      |
| ArrowLineWidth       | Width in pixels of field arrows on WSFplot display screen.                                                             |
| AssumedBeta          | Use this Beta in SFO if calculated value is unphysical.                                                                |
| AxisLineWidth        | Width in pixels of boundary axes on plotting code display screens.                                                     |
| BetaDigits           | Utility code Beta, maximum significant digits (3 to 15) for beta.                                                      |
| BetaTolerance        | Amountover 1.0 before SFO warns of unphysical Beta.                                                                    |
| BoundaryAxes         | Include numbered axes at all four edges of the WSFplot display.                                                        |
| BoundaryColor        | Color of boundary segments in WSFplot.BoundaryLineWidthWidth in pixels of region boundaries on WSFplot display screen. |
| BrowsingForFiles     | Force use of the standard open dialog if no filename specified.                                                        |
| CFishCirclePlot      | Create Quikplot file CircleFit.QKP showing fitted resonance circles.                                                   |
| CircleLineWidth      | Width in pixels of field circles on WSFplot display screen.                                                            |
| CombineTitleLines    | Sets whether to use one line or two lines on the WSFplot title.                                                        |
| ComplexFields        | SF7 to write real and imaginary CFish fields.                                                                          |
| ComputeStoredEnergy  | Sets whether Poisson and Pandira calculate stored energy.                                                              |
| ContourLineWidth     | Width in pixels of field contour lines in WSFplot display screen.                                                      |
| ContourMinimum       | Lowest contour value as percent of range in WSFplot.                                                                   |
| ContourMaximum       | Highest contour value as percent of range in WSFplot.                                                                  |
| CreateOutputTextFile | Sets whether WSFplot writes output file OUTWSF.TXT.                                                                    |
| CurveLineWidth       | Width in pixels of curves on plotting code display screens.                                                            |
| CutoffTerm           | Limiting the number of terms in the field interpolator.                                                                |
| DecimalPlaces        | Sets precision of field data in SF7 output file OUTSF7.TXT..                                                           |
| DeleteNoRingFiles    | If true, CCLfish and CDTfish delete no-ring Superfish files.                                                           |

## WSFplot

Output from WSFplot

The HardCopy, Driver menu lists several software drivers for producing hardcopy graphics files or printing directly to a printer using the Windows Print Manager. Select HardCopy, Start (or the “C” key) to create the hardcopy output. WSFplot re-plots the present screen using the active driver. You can set a preference for the hardcopy driver in file SF.INI.
HardCopyの[ドライバー]メニューには、ハードコピーグラフィックファイルを作成したり、Windowsプリントマネージャーを使用してプリンターに直接印刷したりするためのソフトウェアドライバーがいくつかリストされています。 HardCopy、Start（または「C」キー）を選択して、ハードコピー出力を作成します。 WSFplotは、アクティブなドライバーを使用して現在の画面を再プロットします。ファイルSF.INIでハードコピードライバーのプリファレンスを設定できます。

Programs WSFplot, Quikplot, and Tablplot write a preference file containing saved screen settings to be used the next time the program starts. The name and location of the file depends upon the SF.INI variable SaveSettingsTo. The choices are:
プログラムWSFplot、Quikplot、およびTablplotは、プログラムの次回起動時に使用される保存された画面設定を含む設定ファイルを書き込みます。ファイルの名前と場所は、SF.INI変数SaveSettingsToに依存します。選択肢は次のとおりです。

```msgraph-interactive
SaveSettingsTo = Local Directory
SaveSettingsTo = Individual File
SaveSettingsTo = filename
SaveSettingsTo = directory
```

where filename is the name of an actual file (including path) to be created and directory is the name of an existing directory. The default setting is “Local Directory,” which means that the code will save file WSFPRF.TXT, QplotPRF.TXT, or TplotPRF.TXT in the current directory (usually where the input file resides). Another SF.INI variable, UseSavedSettings, determines whether the code attempts to use the settings in the preference file.
filenameは作成される実際のファイル（パスを含む）の名前で、directoryは既存のディレクトリの名前です。デフォルト設定は「ローカルディレクトリ」です。これは、コードがファイルWSFPRF.TXT、QplotPRF.TXT、またはTplotPRF.TXTを現在のディレクトリ（通常は入力ファイルが存在する場所）に保存することを意味します。別のSF.INI変数UseSavedSettingsは、コードが設定ファイルの設定を使用しようとするかどうかを決定します。

## TablPlot

- User-defined heading lines including justification
- Optional scaling of the data upon start up
- Control over both X and Y scales
- Curve labels
- Log or linear scales
- Polynomial fits for interpolation
- Plots of the fit residuals
- Integration of the data or the fitted curve
- Comment lines in the input file
- Control of the marker size and connecting lines
- Option to include every Nth line of a table (Tablplot)
- Algebraic, trigonometric, or log operations on data sets or columns
- Creation of new data columns by algebraic combination of existing data columns
- Creation of new Tablplot input files containing the currently selected arrays
- Several type of hardcopy graphics outpu

```bash
Quikplot filename time
Tablplot filename time
```

Quikplot and Tablplotpreference files

Quikplot and Tablplot each write a preference file containing saved screen settings to be used the next time the program starts.  
The name and location of the file depends upon the SF.INI variable SaveSettingsTo.  
The choices are:

```bash
SaveSettingsTo = Local Directory
SaveSettingsTo = Individual File
SaveSettingsTo = filename
SaveSettingsTo = directory
```

## LANL

| exe                        |
| -------------------------- |
| AUTOFISH.EXE               |
| AUTOMESH.EXE               |
| beta.exe                   |
| CCLCELLS.EXE               |
| CCLFISH.EXE                |
| CDTFISH.EXE                |
| CFISH.EXE                  |
| CONVERTF.EXE               |
| DTLCELLS.EXE               |
| DTLFISH.EXE                |
| ELLCAV.EXE                 |
| ELLFISH.EXE                |
| FISH.EXE                   |
| FORCE.EXE                  |
| FSCALE.EXE                 |
| KILPAT.EXE                 |
| LIST35.EXE                 |
| MDTCELLS.EXE               |
| MDTFISH.EXE                |
| MK_SFINI.EXE               |
| PANDIRA.EXE                |
| POISSON.EXE                |
| Quikplot.exe               |
| RFQFISH.EXE                |
| SCCFISH.EXE                |
| SEGFIELD.EXE               |
| SF.INI                     |
| SF7.EXE                    |
| SF8.EXE                    |
| SFO.EXE                    |
| SFOTABLE.EXE               |
| Tablplot.exe               |
| wsfcolor.exe               |
| WSFPLOT.EXE                |
