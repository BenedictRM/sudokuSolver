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
%%initialProblem = ([0,0,4,0;1,0,0,0;0,0,0,3;0,1,0,0])%%from lecture
%%initialProblem = ([3,4,1,0;0,2,0,0;0,0,2,0;0,1,4,3])%%solves correctly
%%other 4x4 problems
%%initialProblem = ([1,0,0,3;0,0,4,0;0,1,0,0;2,0,0,4])
%%from attached 4x4 sheet: These are off the top row
%%initialProblem = ([0,0,4,0;3,0,0,2;1,0,0,4;0,3,0,0])%%gives same solution
%%initialProblem = ([0,3,0,2;0,0,1,0;0,4,0,0;3,0,2,0])%%gives same solution
%%initialProblem = ([3,0,2,0;0,2,0,0;0,0,1,0;0,1,0,4])%%gives same solution
%%initialProblem = ([0,0,2,0;4,0,0,3;1,0,0,2;0,4,0,0])%%gives same solution

%%test data (a 9x9 puzzle with known solution, 1. in pdf)
%%Easy 9x9
%%1
%%initialProblem = ([7,2,3,0,0,0,1,5,9;6,0,0,3,0,2,0,0,8;8,0,0,0,1,0,0,0,2;0,7,0,6,5,4,0,2,0;0,0,4,2,0,7,3,0,0;0,5,0,9,3,1,0,4,0;5,0,0,0,7,0,0,0,3;4,0,0,1,0,3,0,0,6;9,3,2,0,0,0,7,1,4])
%%3
%%initialProblem = ([1,0,0,0,0,0,0,0,9;0,4,0,2,6,1,0,3,0;0,6,0,0,5,0,0,1,0;0,0,5,6,0,3,4,0,0;8,1,4,7,0,5,3,9,6;0,0,9,0,1,0,7,0,0;0,0,0,9,3,4,0,0,0;4,8,0,5,7,2,0,6,3;3,0,0,0,0,0,0,0,5])

%%Difficult 9x9
%%1
%%initialProblem = ([0,0,4,0,0,0,3,0,0;2,0,0,7,0,9,0,0,8;0,6,0,5,0,4,0,7,0;0,0,5,0,7,0,2,0,0;4,0,0,3,0,5,0,0,9;0,0,7,0,9,0,5,0,0;0,4,0,9,0,2,0,5,0;8,0,0,6,0,7,0,0,2;0,0,9,0,0,0,1,0,0])
%%2
initialProblem = ([1,5,0,3,0,6,0,8,9;4,0,0,0,0,0,0,0,2;0,0,0,4,2,8,0,0,0;9,0,5,0,3,0,8,0,6;0,0,3,1,0,9,7,0,0;2,0,6,0,5,0,3,0,1;0,0,0,2,1,3,0,0,0;7,0,0,0,0,0,0,0,3;3,9,0,6,0,7,0,5,8])

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
Nsquared = N^2;%place holder
Ncubed = N^3;%This gets used in call to cvx
%%Clue matrix is variable in size based on how many clues we get, dim is
%%dimension of original prob
[A5,b5] = rule5(binaryProblem,N);

%%These four rules are 16x64 in size all with b = 1 for 4x4 case
%%I *think this works for 9x9, may be wrong, this will be the problem child
A1 = rule1(m); %%Fails on 9x9, all other rules good!
A2 = rule2(m);
A3 = rule3(m);
A4 = rule4(m);
%%Store all constraints in single matrix
A = [A1;A2;A3;A4;A5];%%Construct giant matrix
%%This matrix (B) is only for getting b for matrices A1-A4
B = [A1;A2;A3;A4];

%%Get size of B matrix to correctly set b for A1-A4
[r,c] = size(B);
%%b vector is all ones to enforce rules with exception to b5, nice and easy
b = [ones(r,1);b5];

%%CVX Solver
cvx_begin
variables binaryProblem(Ncubed)
minimize(norm(binaryProblem,1))
subject to 
A*binaryProblem==b;
cvx_end

%%Restore to original matrix form
solution = convert_to_integer(binaryProblem);

%%draw sudoku function only set up for 4x4 or 9x9 problems
if(N == 4 || N == 9)
    drawSudoku(initialProblem)
    drawSudoku(solution)
    
else
    %%Show initialProblem again for comparison
    disp(initialProblem)
    disp(solution)
end

end

