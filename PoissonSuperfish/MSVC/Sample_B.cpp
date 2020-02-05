//Developed by Peter de Castro
//Last updated on 7/1/04

#include <fstream.h>
#include "windows.h"

enum{er_None,er_LoadInput,er_LoadDLL,er_LoadInterp,er_InputFile};//Define error codes

//Define the pointer for the function "INTERP"
typedef int (CALLBACK* FuncInterpPointer)(char*,double*,double*,
									    double*,double*,double*,
									    double*,double*,double*);

char SolFileName[256]="SEPTUM.T35";
double			Xval=5,		Yval=5;
double Sol=0,	Xcomp=0,	Ycomp=0;
double Dby_Dy=0,Dby_Dx=0,	Dbx_Dy=0;

HINSTANCE hDLL;					//Declare handle to a DLL
FuncInterpPointer pInterp;		//Declare function pointer

int WINAPI WinMain(HINSTANCE hInstance,HINSTANCE hPrevInstance,LPSTR lpCmdLine,int nCmdShow)//WINAPI==_stdcall
{
	hDLL = LoadLibrary("fld_msvc.dll");//Load the DLL and get the pointer to it

	if (!hDLL)//Check to make sure we have the DLL
	{
		MessageBox(NULL, "Could not load the DLL.", "DLL load error", MB_OK);
		return er_LoadDLL;
	}
	else
	{
		MessageBox(NULL, "DLL loaded.", "DLL load success", MB_OK);

		pInterp = (FuncInterpPointer)GetProcAddress(hDLL,"_INTERP@36");//Get the pointer to the function INTERP
		//The funtion name used above (_INTERP@36) can be found by running "dumpbin /exports fld_msvc.dll" at the command prompt.
		
		if (!pInterp)//Check to make sure we have the function
		{
			MessageBox(NULL, "Could not load the function.", "Function load error", MB_OK);
			FreeLibrary(hDLL);       
			return er_LoadInterp;
		}
		else
		{
			MessageBox(NULL, "Function loaded.", "Function load success", MB_OK);
			//Call the function
			int ReturnVal=pInterp(SolFileName,&Xval,&Yval,&Sol,&Xcomp,&Ycomp,&Dby_Dy,&Dby_Dx,&Dbx_Dy);
			if(ReturnVal<0)
			{
				MessageBox(NULL, "Invalid or unsolved input file.", "Input file error", MB_OK);
				return er_InputFile;
			}
		}
	}

	//Create a file for storage of results, and write the results to it.
	ofstream OFile("output.txt",ios::out|ios::app);
	OFile<<"x:"<<Xval<<"\ny:"<<Yval<<"\nSolution:"<<Sol<<"\nX component:"<<Xcomp<<"\nY component:"<<Ycomp
		<<"\ndBy/dy:"<<Dby_Dy<<"\ndBy/dx:"<<Dby_Dx<<"\ndBx/dy:"<<Dbx_Dy<<"\n";
	OFile.close();

	FreeLibrary(hDLL);
	return er_None;
}