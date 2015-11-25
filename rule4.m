function [A4] = rule4(size)
%%RULE 4: Each integer (1-m (number of rows))should only show up once: in each space
%%Input: number of rows of original prob (N) in order to build matrix
%%Output: an (NN) matrix formatted s.t. it constrains problem to rule 4

N = size;
Nsquared = N^2;
Ncubed = N^3;
FOURONES = ones(1,N);

%Initialize A4
A4 = zeros(Nsquared,Ncubed);%%in 4x4 case, 64 values repr each cell in row
                            %%16 cells in total or 16 rows, 64 columns
%%populate the DIAGONAL of A4's cells with 1's to constrain to rule 4
for i = 1:Nsquared
    %%Want first cell to be repr by all ones
    %%A4(1,1:N) = FOURONES i.e. want vals at row 1 col 1 thru N to be a 1
    %%Step, now want A4(2,4:N) = FOURONES etc.
    A4(i, N*(i-1) + 1 : i*N) = FOURONES; %%Set the diagonal of A4 to 1
end

end

