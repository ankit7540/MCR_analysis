#pragma rtGlobals=3		// Use modern global access method and strict wave access.

// function to map H matrix to 2D matrices for image generation
// H matrix is output of MCR analysis

//	Parameters
//	y_pnts	: number of points in y
//	x_pnts	: number of points in x
function map_H_matrix(matH, y_pnts, x_pnts)
wave matH // H_matrix
variable y_pnts, x_pnts

Variable microSeconds
Variable timerRefNum
timerRefNum = startMSTimer



variable x1,x2
x1=dimsize(matH,0)
x2=dimsize(matH,1)

print x1,x2

variable i,j, k
string wname=nameofwave(matH)
string output_name

variable factor=(x2/y_pnts)
printf "factor : %g   \r", factor
if ( mod(x2, y_pnts) >0 )
	abort "Check input for y_pnts"
endif
if ( factor != x_pnts )   
	abort "Check input  for x_pnts"
endif
//duplicate /d matH, tmpH
//wave tmpH, tmpH
matrixop /o tmpH=matH^t

for (i=0 ; i<x1 ; i=i+1)
		
	sprintf 	output_name, "%s_out_%g",wname,i
	print output_name
	
	make /o /d /n=(x_pnts, y_pnts) $output_name=0
	wave opwave=$output_name
	
	for (j=0 ; j< (y_pnts) ; j=j+1)

		for ( k =0 ; k < (x_pnts) ; k = k+1)
			// print i,j,k, (factor*j)+k   
			opwave[k][j] = tmpH[  ((factor*j)+k)  ][i]
				
		endfor 
	
	endfor
	
endfor


killwaves /Z tmpH

microSeconds = stopMSTimer(timerRefNum)
Print microSeconds/10000, "microseconds"

end
