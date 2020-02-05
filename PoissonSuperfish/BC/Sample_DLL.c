// File Sample_DLL.C

//  This Borland C source program, provided as an example for code 
//  developers, was developed by Harunori Takeda, Los Alamos National 
//  Laboratory. 

//  This program reads the TAPE35 solution file HTEST1.T35 from the 
//  H-Magnet example by calling the INTERP function in file Fld_BC.DLL.  
//  The code produces the same result as the LF95 program Sample.f90, 
//  which links to object modules in a Fortran 95 library.  Output is 
//  a Quikplot input file containing By versus X.

//  Copyright 2003, by the University of California.
//  Unauthorized commercial use is prohibited.

//  You are free to modify this file as needed for your own use.  See
//  the section "Files provided for program developers" in the Poisson
//  Superfish documentation for a description of the field interpolator
//  calling parameters.  This file is provided as is, without any
//  additional documentation other than that mentioned above.

//  Los Alamos National Laboratory cannot provide consulting for source-
//  code developers.


#pragma hdrstop

#include <ctype.h>
#include <stdarg.h>
#include <string.h>
#include <signal.h>
#include <limits.h>
#include <errno.h>
#include <math.h>
#include <time.h>
#include <float.h>
#include <stdio.h>

#define _X86_
#include "windows.h"

//  ** Declaration of function prototype of functions from the Import lib **

__declspec(dllimport) int	_stdcall INTERP(const char* SolutionFile, const double* Xval, const double* Yval,
						double* Az_, double* Bx_, double* By_, 
						double* DBYDY_, double* DBYDX_, double* DBXDY_, 
						long int SolutionFile_len);
__declspec(dllimport) double	_stdcall R_VARIABLE(const char* Vname, long int Vname_len);
__declspec(dllimport) int	_stdcall GETTITLE(const char* Title, long int Title_len);

//__declspec(dllimport) int 	_stdcall I_VARIABLE(const char* Vname, long int Vname_len);
void TRIM(char* Title80);

#pragma argsused
int WINAPI WinMain(HANDLE hInstance, HANDLE hPrevInstance,
    LPSTR lpCmdLine, int nCmdShow) {

	FILE *file45;

	int 	j=0, len80=0, jend=0;
	long	Iresult = 0;

	double Xval =	0.0,	Yval =	0.0,	Az_ =	0.0,	Bx_ =	0.0,
               By_ = 	0.0,	DBYDY_ =0.0,	DBYDX_ =0.0,	DBXDY_ =0.0;
	double conv, Xmax, xinc;

	char* file45name= "result.txt";
	char Title[800];
	char Title80[10][81], Title80Tmp[81];

    char* SolutionFile="e:\\lf90_files\\HTEST1.T35";
    char* CONVname= "CONV    ";
    char* XMAXGname="XMAXG   ";
//========================================================

      file45= fopen("HTEST1.QKP","w");

      Xval= 0.;
      Yval= 0.;

	Iresult=INTERP(SolutionFile,&Xval,&Yval,
		&Az_, &Bx_,&By_,&DBYDY_,&DBYDX_,&DBXDY_, 256);
	switch (Iresult) {
	case 0:    //Operation successful. continue with program.
		break;
	case -1:  //No such file
		fprintf(file45,"The file %s oes not exist. Error\n",SolutionFile);
		exit(0);
		break;
	case -2:  // DLL could not allocate arrays
		fprintf(file45,"Function INTERP was unable to allocate solution arrays.\n");
		exit(0);
		break;
	case -3:  //File read successfully, but point not in problem. Continue with program.
		break;
	case -4:  // DLL could not determine solution file version
		fprintf(file45,"Function INTERP was unable to determine the solution file version.\n");
		exit(0);
		break;
	case -5:  // DLL cannot read version 6 files
		fprintf(file45,"Function INTERP cannot read solution files written by Poisson Superfish version 6.\n");
		exit(0);
		break;
	default:
		if (100 <= Iresult && Iresult <= 999) {
			fprintf(file45,"Function INTERP returned error code %3i . \n",Iresult);
			fprintf(file45,"Refer to Table II-6 in file SFintro.DOC. Error\n");
			exit(0);
		}
		else {
	  	fprintf(file45,"Function INTERP returned an unknown error code: %3i \n\n");
		fprintf(file45,"Please report the problem to Superfish@lanl.gov. Error\n");
		exit(0);		
		}
	}
//	fprintf(file45,";Iresult=%d\n",Iresult);

//  Poisson Superfish length variables are in cm.  CONV is the units conversion
//  factor (e.g., CONV = 2.54 if user's units are inches).  Function INTERP assumes
//  Xval and Yval are in user's units.

      conv=R_VARIABLE(CONVname,8);
//      fprintf(file45,";CONVname conv=%f\n",conv);

//  Get the maximum X coordinate in the problem and convert to user's units.
//
      Xmax=R_VARIABLE(XMAXGname,8)/conv;
//      fprintf(file45,";XMAXGname Xmax=%f\n\n",Xmax);

//  Get the ten 80-character title lines and store each line in Title80. 
//  Do not print the trailing blanks.

     Iresult=GETTITLE(Title,800);
     for( j=0; j<10; j++) {
	     strncpy(Title80[j],Title+80*j,80);
             len80 = strlen(Title80[j]) <= 80 ? strlen(Title80[j]): 80;
	     if (!len80) { jend= j-1; break; }
	     Title80[j][len80]= '\0';    // Terminate the line
	     TRIM(Title80[j]);
	     strcpy(Title80Tmp,Title80[j]);  // save Title80[j]
	     if(!strtok(Title80Tmp," ")) { jend=j-1; break; }  // ignore blank lines

//	     len80= strlen(Title80[j]);
//	     fprintf(file45,";len80=%d **:%s\n",len80,Title80[j]);
     }
//
//   Open a text file and write By versus X to a Quikplot data file.

      fprintf(file45,"; File HTEST1.QKP\n");
      fprintf(file45,"; Sample Quikplot file using the Poisson Superfish field interpolator\n\n");
      fprintf(file45,"Center\nTitle\nBy versus x from Poisson/Pandira problem: %s\n",Title80[0]);
      if(jend >=1) fprintf(file45,"\nSubtitle\n%s\n",Title80[1]);
      if(jend >=2) {
      	fprintf(file45,"\n;Remaining title lines:\n");
	for(j=2; j<=jend && j<10; j++) fprintf(file45,";%s\n",Title80[j]);
	}
      fprintf(file45,"\nXLabel\nX Position (cm)\nYLabel\nBy (Gauss)\n\nData\n");

      Yval=0.0;
      xinc=Xmax/200.0;
      for (j=0; j<=200; j++) {
        Xval= j* xinc;
	Iresult=INTERP(SolutionFile,&Xval,&Yval,
		&Az_, &Bx_,&By_,&DBYDY_,&DBYDX_,&DBXDY_, 256);

        if(Iresult == 0) fprintf(file45,"%15.7e %15.4e\n",Xval,By_);
      }
      fprintf(file45,"EndData\n\nEndFile");
      fclose(file45);

	return 0;
} 
//========================================================
// Trim the trailing space characters from a line Title80.
void TRIM(char* Title80){

	int lenstr=0, lennew=0, i=0;

	if((lennew= lenstr= strlen(Title80)) >= 1 ) {
		for(i=lenstr-1; i>=0; i--,lennew--) {
		 if(Title80[i] != ' ') break;
		}
	 Title80[lennew]= '\0';
	}
}
//========================================================

