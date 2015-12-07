%%From http://www.mathworks.com/help/optim/ug/solve-sudoku-puzzles-via-integer-programming.html
%%I wanted a way to format output, and mathworks provides one!
%%I edited the original function s.t. it was more arbitrary than 9x9
function drawSudoku(B, windowTitle)
% Function for drawing the Sudoku board
%   Copyright 2014 The MathWorks, Inc. 

[m,n] = size(B);

%9x9
if(m == 9)
    figure('name',windowTitle);hold on;axis off;axis equal % prepare to draw
    rectangle('Position',[0 0 9 9],'LineWidth',3,'Clipping','off') % outside border
    rectangle('Position',[3,0,3,9],'LineWidth',2) % heavy vertical lines
    rectangle('Position',[0,3,9,3],'LineWidth',2) % heavy horizontal lines
    rectangle('Position',[0,1,9,1],'LineWidth',1) % minor horizontal lines
    rectangle('Position',[0,4,9,1],'LineWidth',1)
    rectangle('Position',[0,7,9,1],'LineWidth',1)
    rectangle('Position',[1,0,1,9],'LineWidth',1) % minor vertical lines
    rectangle('Position',[4,0,1,9],'LineWidth',1)
    rectangle('Position',[7,0,1,9],'LineWidth',1)
end

%4x4
if(m==4)
    figure('name',windowTitle);hold on;axis off;axis equal % prepare to draw
    rectangle('Position',[0 0 4 4],'LineWidth',3,'Clipping','off') % outside border
    rectangle('Position',[2,0,2,4],'LineWidth',2) % heavy vertical lines
    rectangle('Position',[0,2,4,2],'LineWidth',2) % heavy horizontal lines
    rectangle('Position',[0,1,4,1],'LineWidth',1) % minor horizontal lines
    rectangle('Position',[0,2,4,1],'LineWidth',1)
    rectangle('Position',[1,0,1,4],'LineWidth',1) % minor vertical lines
    rectangle('Position',[2,0,1,4],'LineWidth',1)
end

% Fill in the clues
%
% The rows of B are of the form (i,j,k) where i is the row counting from
% the top, j is the column, and k is the clue. To place the entries in the
% boxes, j is the horizontal distance, 10-i is the vertical distance, and
% we subtract 0.5 to center the clue in the box.
%
% If B is a 9-by-9 matrix, convert it to 3 columns first

%%draw 9x9 results
if(m == 9)
    if size(B,2) == 9 % 9 columns
        [SM,SN] = meshgrid(1:9); % make i,j entries
        B = [SN(:),SM(:),B(:)]; % i,j,k rows
    end

    for ii = 1:size(B,1)
        if(B(ii,3)>0)
            text(B(ii,2)-0.5,9.5-B(ii,1),num2str(B(ii,3)))
        end
    end
end

%%draw 4x4 matrix results
if(m==4)
    if size(B,2) == 4 % 4 columns
        [SM,SN] = meshgrid(1:4); % make i,j entries
        B = [SN(:),SM(:),B(:)]; % i,j,k rows
    end
    for ii = 1:size(B,1)
        if(B(ii,3)>0)
            text(B(ii,2)-0.5,4.5-B(ii,1),num2str(B(ii,3)))
        end
    end
end



hold off

end

