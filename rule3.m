function [A3] = rule3(size)
%%RULE 3: Each integer (1-m (number of rows))should only show up once: in each
%%column
%%Input: number of rows of original prob (N) in order to build matrix
%%Output: an (NN) matrix formatted s.t. it constrains problem to rule 3

N = size;
Nsquared = N^2;
Ncubed = N^3;

%Initialize A3
A3 = zeros(Nsquared,Ncubed);%%in 4x4 case, 64 values repr each cell in row
                            %%16 cells in total or 16 rows, 64 columns

%%Nsquared = number of constraints
for i = 1:Nsquared
    %%updateCell used to jump around constraint
    updateCell = i;
    
    %%Keep track of number of cells getting set
    numberOfCellsSet = 0;
    
    %%Set entire constraint, we do this 16 times
    for j = 1:Ncubed
        if((j == updateCell) && (numberOfCellsSet < N))
            A3(i,j) = 1;%%at row i, columnn j
            %%Move up a column
            updateCell = updateCell + Nsquared;
            numberOfCellsSet = numberOfCellsSet + 1;
        else
            A3(i,j) = 0;
        end
    end
end
%%end of function
end

