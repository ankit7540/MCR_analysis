function count_column_occurence (input , reference)
	wave input		// large matrix in which data is checked
	wave reference	// reference matrix, a subset of input
	
	variable nRows, nCols
	variable nRows_input, nCols_input
	variable i, j
	variable prev_j=0
	variable count 
	
	nRows = dimsize ( reference, 0)
	nCols = dimsize ( reference, 1)
	nRows_input = dimsize ( input, 0)
	nCols_input = dimsize ( input, 1)
	
	make /o /d /n=(nCols_input ) output=0
	make /FREE /o /d /n=(nRows) temp
	make /FREE /o /d /n=(nRows) temp_input
	
	for ( i=0 ; i < nCols ; i=i+1)	// checking all cols of the subset
		temp[] = reference [p][i]
		
		// perform check
		for ( j=prev_j ; j < nCols_input ; j=j+1)
			temp_input [] = input [p][j]
			
			findSequence /V = temp temp_input
			
			if ( V_value != -1)
				prev_j = j
				output [j] = 1
				// print i, j, "found" 
				
				//make /FREE /o /d /n=(nRows) compare_output
				break
			endif	
			
		endfor	
		
	endfor	
	
count = wavesum ( output ) 	
print "Total occurences : ", count 
end	

//************************************************************************************************
// ***********************************************************************************************

function count_column_occurence_and_save (input , reference)
	wave input		// large matrix in which data is checked
	wave reference	// reference matrix, a subset of input
	
	variable nRows, nCols
	variable nRows_input, nCols_input
	variable i, j
	variable prev_j=0
	variable count 
	
	nRows = dimsize ( reference, 0)
	nCols = dimsize ( reference, 1)
	nRows_input = dimsize ( input, 0)
	nCols_input = dimsize ( input, 1)
	
	make /o /d /n=(nCols_input ) output=0
	
	//  make with '/FREE' keeps the wave in memory, allows fast access
	make /FREE /o /d /n=(nRows) temp
	make /FREE /o /d /n=(nRows) temp_input
	
	// make 2D wave to keep matched data
	// waves made with wave can be referenced directly
	make /o /d /n=(nRows, nCols) matched
	
	for ( i=0 ; i < nCols ; i=i+1)	// checking all cols of the subset
		temp[] = reference [p][i]
		
		// perform check
		for ( j=prev_j ; j < nCols_input ; j=j+1)
			temp_input [] = input [p][j]
			
			findSequence /V = temp temp_input
			
			if ( V_value != -1)
				prev_j = j
				output [j] = 1
				// print i, j, "found" 
				
				
				break
			endif	
			
		endfor	
		
	endfor	
	
count = wavesum ( output ) 	
print "Total occurences : ", count 
end	

//************************************************************************************************
// ***********************************************************************************************

// WaveSum(w)
// Returns the sum of the entire 1D wave

//	Parameters:
//		w	=	1D wave
Function WaveSum(w)
	Wave w
	Variable i, n=numpnts(w), total=0
	
	for(i=0;i<n;i+=1)
		total += w[i]
	endfor
	
	return total
End

// ***********************************************************************************************
// ***********************************************************************************************
