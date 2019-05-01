#pragma rtGlobals=3		// Use modern global access method and strict wave access.

//********************************************************************************************
//********************************************************************************************

// purpose : Reconstructig MCR data for each pixel for the n components

function reconstruct_spectra ( wM, hM)
	wave wM	// spectra matrix (has n components along the cols  having n  data points)
	wave hM	// weight matrix  (has n components along Rows, with total m pixels)
	
	variable nRows_w = dimsize(wM, 0)
	variable nCols_w = dimsize(wM, 1)
	variable nRows_h = dimsize(hM, 0)
	variable nCols_h = dimsize(hM, 1)
	
	print nRows_w, nCols_w, nRows_h, nCols_h
	
	make /d /o /n=(nRows_w, nCols_h* nRows_h ) output
	printf "output  dimension = %g,  %g\r",nRows_w, (nCols_h* nRows_h)
	
	variable count 
	variable i,j
	
	make /o /FREE /n=(nRows_w) temp
	
	for (i=0 ; i< nCols_w  ; i=i+1)
		for (j=0 ; j< nCols_h  ; j=j+1)
				
				temp = wM[p][i] * hM [i][j]		// multiplication
				
				output [][count] = temp[p]	// assign to output
				count=count+1
			// print i,j, count
		endfor
	endfor	
end	
//********************************************************************************************
//********************************************************************************************
