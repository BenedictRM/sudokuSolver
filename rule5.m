function [A5,b5] = rule5(binarySudoku,dim)
%RULE5: This rule states that initial clues cannot be replaced
%%It is variable in size because the number of clues changes 
%%We will return a variable b5 corresponding to the clues
%%Input
%%Output: Variable A5 matrix and b5 vector

%%Examine 4 elem's at a time from binarySudoku and construct matrix if a 1
%%exists within those 4 elements, b5 is then only elem's that have a 1
%%In A5 construction, add 4 0's for each for elements examined to left
%%side, subtract 4 from #rows worth (rows of binary) on right side 

%INITIALIZATION IDEA: FIND TOTAL # OF CLUES FIRST THEN INITIALIZE VARS
%BASED ON THAT NUMBER

%%Start by constructing just one piece of this
[m,n] = size(binarySudoku);
left = 0;
right = m - dim;%dim is dimension of original problem
i = 1;
rowadder = 1;%%Update each time a row is added
%%initialze matrices, rows = dim * number_of_clues, cols = rows of binary
number_of_clues = 0;
%%Discovering how many clues we start with
for p = 1:m
    if(binarySudoku(p,1) == 1)
        number_of_clues = number_of_clues + 1;
    end
end
%%Initialize variables
rows = number_of_clues * dim;
A5 = zeros(rows,m);
b5 = zeros(rows,1);

%%Just search the first row, dim# elem's at a time
while(i <= m)
    %%Checking dim# elements at a time, - 1 for off by one error
    for j = i:(i + (dim - 1)) 
        %%clue found step back and fill array
        if(binarySudoku(j,1) == 1)
            L = zeros(1,left);
            R = zeros(1,right);
            k = 0;%step back to starting location
            %%Construct an Identity matrix to step through
            I = eye(dim);
            Irow = 1;
            while(k < dim)
                A5(rowadder + k,1:m) = [L,I(Irow,1:dim),R];
                k = k + 1;
                Irow = Irow + 1;
            end
            %%Update rowadder
            rowadder = rowadder + dim;
        end
    end
    
    i = i + dim;
    left = left + dim;
    right = right - dim;
end

%%Construct b matrix
%%search dim elements at a time, if 1 encountered add to b
bIterator = 1;
q = 1;
while(q <= m)
    for t = q:(q + (dim - 1))
        if(binarySudoku(t,1)==1)
            binElem = q;
            %step back to q and copy 4 elements
            for copy = 1:dim
                b5(bIterator,1) = binarySudoku(binElem,1);
                bIterator = bIterator + 1;
                binElem = binElem + 1;
            end
        end
    end   
	q = q + dim;
end
end

