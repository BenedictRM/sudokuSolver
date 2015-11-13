function [binarySudoku] = convert_to_binary(originalSudoku)
%%CONVERT_TO_BINARY 
%%This funciton will take original input sudoku puzzle and convert it
%%to a binary problem, each cell is represented by n (number of columns)
%%binary numbers to represent 1-n being the integer of that cell
%%for example a 4x4 puzzle will output 64 variables (4x4x4), 
%%every four repr a new cell in the puzzle

%%initialize
%%Always one column with m^3 rows
[rows,columns] = size(originalSudoku);
rowsCubed = rows^3;
binarySudoku = zeros(rowsCubed,1);%initialize to zero
arraypos = 1;

%%step through original problem assigning 1's where clues exist
for i = 1:rows
   for j=1:columns
       
       element = originalSudoku(i,j);%%get element at row i, column j
       %%Represent cell in binary
       for k = 1:rows %%Set row number of variables
           %%if cell is 1 in orig, then first is 1, next three == 0
           if(element == k)
               binarySudoku(arraypos,1) = 1;
           
           %%else this must be a 0
           else
               binarySudoku(arraypos,1) = 0;
           end
           
           arraypos = arraypos + 1;%%Advance the array position
           
       end
   end
end
%%End of function
end

