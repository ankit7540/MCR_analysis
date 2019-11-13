// To check matching columns in two matrices. One is the reference (smaller) and other
//	is the input (larger matrix). 
//	'count_column_occurence' : performs counting only
//	'count_column_occurence_and_save' : counting and saving matched columns

function count_column_occurence (input , reference)
	wave input		// large matrix in which data is checked
	wave reference	// reference matrix, a subset of input
	
	variable nRows, nCols
	variable nRows_input, nCols_input
	variable i, j
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
		for ( j=0 ; j < nCols_input ; j=j+1)
			temp_input [] = input [p][j]
			
			findSequence /V = temp temp_input
			
			if ( V_value != -1)
				output [j] = 1	// used for counting occurences
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

function count_column_occurence_and_save (input , reference)
	wave input		// large matrix in which data is checked
	wave reference	// reference matrix, a subset of input
	
	variable nRows, nCols
	variable nRows_input, nCols_input
	variable i, j
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
	// waves made with 'make' can be referenced directly
	make /o /d /n=(nRows) matched
	
	printf "Size of the reference : %g x %g\r", nRows,nCols 
	
	for ( i=0 ; i < nCols ; i=i+1)	// checking all columns of the subset
		temp[] = reference [p][i]
		//print i
		
		// perform check
		for ( j= 0  ; j < nCols_input ; j=j+1)
			temp_input [] = input [p][j]
			
			findSequence /V = temp temp_input
			
			if ( V_value != -1)
				output [j] = 1
				//print i, j, "found" 
				count=count+1			
				InsertPoints/M=1 count,1, matched
				matched[][count] = reference [p][i]	
				break
			endif	
			
		endfor	
		
	endfor	
	
print "Total occurences : ", wavesum ( output )

DeletePoints/M=1 0,1, matched

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
