function [integerSudoku] = convert_to_integer(binarySudoku)
%CONVERT_TO_INTEGER
%%This function will restore the original sudoku to human readable integer
%%sudoku.  Or it will convert the final solution to human readable integer
%%sudoku.
%%Input: a binary repr of a sudoku puzzle
%%Output: an integer matrix representation of the binary puzzle

[rows,columns] = size(binarySudoku);%%Need to step through this many elements
%%Initialize integerSudoku--always cube root rows/columns (#rows==#columns)
cubeRootRows = int8(rows^(1/3));%%be sure to cast to 8 bit int
integerSudoku = zeros(cubeRootRows,cubeRootRows);%%reform square matrix
[m,n] = size(integerSudoku);%%Store the number of rows and columns assoc with this
curRow = 1;%%Start at row one and go
binarySudoku = int8(binarySudoku);%%cast elements in binarySudoku to int since they may not be ints 

%%Restore original problem
for intRow = 1:m
    for intCol = 1:n
    cellVal = 0;
    i = 1;
        %%Discover the cell value
        while(i <= cubeRootRows)%%cubeRootRows represents the number of possible ints
            
            if(binarySudoku(curRow,1) == 1)
                cellVal = i;
            end
            i = i + 1;
            curRow = curRow + 1;%%Advance the row we're looking at
        end
    %%set the cell value in original problem
    integerSudoku(intRow,intCol) = cellVal;
    end
end

end

