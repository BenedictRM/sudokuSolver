function [A2] = rule2(size)
%%RULE 2: Each integer (1-m (number of rows))should only show up once: in each
%%row
%%Input: number of rows of original prob (N) in order to build matrix
%%Output: an (NN) matrix formatted s.t. it constrains problem to rule 2

N = size;
Nsquared = N^2;
Ncubed = N^3;

%Initialize A2
A2 = zeros(Nsquared,Ncubed);%%in 4x4 case, 64 values repr each cell in row
                            %%16 cells in total or 16 rows, 64 columns

%%total cells set
totalCellsSet = 0;
%%step along cols
step = 1;
%%Keep track of the number of iterations so we know when to advance
iterations = 1;
%%Nsquared = number of constraints
for i = 1:Nsquared
    %%updateCell used to jump around constraint
    updateCell = step;

    %%Keep track of number of cells getting set so we don't set too many
    numberOfCellsSet = 0;
    
    %%Set entire constraint, we do this 16 times
    for j = 1:Ncubed
        if((j == updateCell) && (numberOfCellsSet < N))
            A2(i,j) = 1;%%at row i, columnn j
            %%Move up a column
            updateCell = updateCell + N;
            numberOfCellsSet = numberOfCellsSet + 1;
            totalCellsSet = totalCellsSet + 1;
        else
            A2(i,j) = 0;
        end
    end

    %%At this point a row has been set--advance step to next row
    if(totalCellsSet == Nsquared)
        %%Update row position
        step = (Nsquared * iterations) + 1;
        iterations = iterations + 1;
        totalCellsSet = 0;%%reset--need to update this many cells again
    else
        step = step + 1;%%step along
    end      
end
%%end of function
end

