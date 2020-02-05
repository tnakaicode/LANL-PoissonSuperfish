#include <fstream.h>
#include "windows.h"

//import function "INTERP(...)" from library "fld_msvc.h"
extern "C" __declspec(dllexport) int _stdcall INTERP(const char* SolutionFile,	double* Xvalue,		double* Yvalue,
													 double* Solution,			double* Xcomponent,	double* Ycomponent,
													 double* DBYDY,				double* DBYDX,		double* DBXDY);


//pass variables to INTERP and print results to file
int _stdcall WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance,LPSTR lpCmdLine,int nCmdShow)
{
	char SolutionFile[256]="SEPTUM.T35";
	double			Xvalue=5,	Yvalue=5,
		Solution=0,	Xcomp=0,	Ycomp=0,
		DBYDY=0,	DBYDX=0,	DBXDY=0;

	INTERP(SolutionFile,&Xvalue,	&Yvalue,
		   &Solution,	&Xcomp,		&Ycomp,
		   &DBYDY,		&DBYDX,		&DBXDY);

	ofstream OFile("output.txt",ios::out|ios::app);
	OFile<<"x:"<<Xvalue
		<<"\ny:"<<Yvalue
		<<"\nSolution:"<<Solution
		<<"\nX component:"<<Xcomp
		<<"\nY component:"<<Ycomp
		<<"\ndBy/dy:"<<DBYDY
		<<"\ndBy/dx:"<<DBYDX
		<<"\ndBx/dy:"<<DBXDY
		<<"\n";
	OFile.close();
    return 0;
}
 
