function [] = main()
%%Driver program to solve a sudoku puzzle
%%Input: an nxn matrix of at least size 4x4 to 9x9 that repr a sudoku
%%Intention is to let user input a puzzle with clues
%%Solver will then try to output a solution

%{
Defining A and b (constraints) on
Sudoku rules (5):
Each integer (1-m (number of rows))should only show up once:
1) in each 2x2 space or 3x3 space
2) in each row
3) in each column
4) in each space
5) and initial clues should not be replaced
%}

%%test data (a 4x4 puzzle with known solution)
initialProblem = ([0,0,4,0;1,0,0,3;0,0,0,0;0,1,0,0])
%%Alternative 4x4 sudoku to check initialization stuff
%initialProblem = ([3,4,1,0;0,2,0,0;0,0,2,0;0,1,4,3]);
%%test data (a 9x9 puzzle with known solution, 1. in pdf)
%%initialProblem = ([0,0,4,0,0,0,3,0,0;2,0,0,7,0,9,0,0,8;0,6,0,5,0,4,0,7,0;0,0,5,0,7,0,2,0,0;4,0,0,3,0,5,0,0,9;0,0,7,0,9,0,5,0,0;0,4,0,9,0,2,0,5,0;8,0,0,6,0,7,0,0,2;0,0,9,0,0,0,1,0,0])
%%Hold original problem size:
[m,n] = size(initialProblem);

%%This is our x variable with clues included
binaryProblem = convert_to_binary(initialProblem);

%%NOTE I suspect if either an int shows up once per row/column then rule 1 
%%Must ALSO be satisfied (same with rule1 and either rule 2/3 would satisfy
%%The remaining constraint, therefore maybe only need to have 4 constraints
%%Might be a good proof for paper

%%Build 'A' matrix based on sudoku rules
N = m;%place holder
Nsquared = N ^2;%place holder
Ncubed = N^3;%placeholder
%%Clue matrix is variable in size based on how many clues we get, dim is
%%dimension of original prob
[A5,b5] = rule5(binaryProblem,N);
%%Just checking correct size of clue matrix
[z,x] = size(A5);
%%These four rules are 16x64 in size all with b = 1 for 4x4 case
A1 = zeros(Nsquared,Ncubed);%%Place holder
A2 = zeros(Nsquared,Ncubed);%%Place holder
A3 = zeros(Nsquared,Ncubed);%%Place holder
A4 = rule4(m);
A = [A1;A2;A3;A4];%%Construct giant matrix
%%Get size of A matrix to correctly set b
[r,c] = size(A);
%%B vector is all ones to enforce rules, nice and easy
b = [ones(r,1)];

%%*******Final solution will look something like this:****
%%This will need to get tweaked, not sure how to feed correct vals
%%Guessing L1 based on x vector
%%get L1 norm so we solve w.r.t. to L1 
%L1 = norm(binaryProblem,1);%returns the L1 norm of matrix x (first position)
%L1 = linprog(binaryProblem,A,b);%%Final prob will look like this once constraints done
%%*****end of example******

%%Restore to original matrix form
solution = convert_to_integer(binaryProblem)

end

