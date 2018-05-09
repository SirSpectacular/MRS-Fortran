all:
	ifort -std08 -fpp -D"P=4" gauss.f90 str2int.f90 MRS.f90 -o "MRS_P4"
	ifort -std08 -fpp -D"P=8" gauss.f90 str2int.f90 MRS.f90-o "MRS_P8"
	ifort -std08 -fpp -D"P=16" gauss.f90 str2int.f90 MRS.f90 -o "MRS_P16"
clean:
	-rm -r MRS_* *.mod *.obj