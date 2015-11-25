function [A1] = rule1(size)
%%RULE 1: Each integer (1-m (number of rows))should only show up once: in each
%%NxN cell
%%Input: number of rows of original prob (N) in order to build matrix
%%Output: an (NN) matrix formatted s.t. it constrains problem to rule 3

N = size;
Nsquared = N^2;
Ncubed = N^3;

%Initialize A2
A1 = zeros(Nsquared,Ncubed);%%in 4x4 case, 64 values repr each cell in row
                            %%16 cells in total or 16 rows, 64 columns

%%step along cols
step = 1;
%%Keep track of the number of iterations so we know how far to advance
iterations = 1;%%Used primarily in case of a 9x9
%%This keeps track of how many cells have been set in a row of cells
cellsSet = 0;
%%Total number of cells in a row, if reach this number reset to left
reset = sqrt(N);
%%Keeps track of number of big cells set
bigCellsSet = 0;
%%Keeps track of how many constraints got set
constraints = 0;
%%to keep track of pre jump locations
lastPositionBeforeJump = 0;
%%boolean to only set above value exactly once
jumped = 0;

%%Nsquared = number of constraints
for i = 1:Nsquared
    %%updateCell used to jump around constraint
    updateCell = step;

    %%Keep track of number of cells getting set so we don't set too many
    numberOfCellsSet = 0;
    
    %%Set entire constraint, we do this 16 times
    for j = 1:Ncubed
        if((j == updateCell) && (numberOfCellsSet < N))
            A1(i,j) = 1;%%at row i, columnn j
            numberOfCellsSet = numberOfCellsSet + 1;
            cellsSet = cellsSet + 1;
            %%Jump to next row we will then set two more cells, the two
            %%should be changed here to match 9x9, this is for 4x4, might
            %%be N
            if(cellsSet == reset)
                %%jump exactly once
                if(jumped == 0)
                    %%Store prejump pos
                    lastPositionBeforeJump = updateCell;
                    jumped = 1;
                end
                
                %%make jump
                updateCell = Nsquared + step;
                cellsSet = 0;
 
            else
                updateCell = updateCell + N;
            end
        else
            A1(i,j) = 0;
        end     
    end
    %%We have now set an additional constraint
    constraints = constraints + 1;
    %%reset jumped
    jumped = 0;
    
    %%If set N constraints, time to jump right
    if (constraints == N)
        %%We do this because we need a way of say getting from x_24 to x_9
        step = lastPositionBeforeJump;
        %%At this point one big cell has been set
        bigCellsSet = bigCellsSet + 1;
        %%reset constraints
        constraints = 0;
    end
    
    %%Check how step advances
    if(bigCellsSet == reset)
        step = ((Ncubed * iterations/reset) +1);%%Make a big jump to left
        %%Reset this counter
        bigCellsSet = 0;
        %%update number of iterations
        iterations = iterations + 1;
    %%Step just advances like normal
    else
        step = step + 1;%%step along
    end 
end
%%end of function
end

