% close all
clear all

% coorInfo:
%   row 1 -> radius
%   row 2 -> phi   -> range: 0 ~ 2pi
%   row 3 -> theta -> range: 0 ~ pi



dim = '-';

% charge      = [-1 -1 +1 +1];
% grouped     = [1 3; 2 4];
% coorInfo    = [ 15,  15, 15, 15;...  % radius 
%                -150,  -30, 150,  30;...  % alpha (xy coordinate)
%                 90,   90,  90,  90];
            
% paper result - DONT FORGET make x dimension 0!
% charge      = [-1 -1 +1 +1];
% grouped     = [1 3; 2 4];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2;...  % radius 
%                -170,  -10, 140,  40;...  % alpha (xy coordinate)
%                 90,   90,  90,  90];
% dim = 'x';

% paper result (rotated) - DONT FORGET make z dimension 0! z, because the x is now basically z!
% charge      = [-1 -1 +1 +1];
% grouped     = [1 3; 2 4];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2;...  % radius 
%                  90,   90,  90,  90;...  % alpha (xy coordinate)
%                -170,  -10, 140,  40];
% dim = 'z';

% charge      = [-1 -1 +1 +1];
% grouped     = [1 3; 2 4];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2;...  % radius 
%                -90,  -90, -90,  -90;...    % alpha (xy coordinate)
%                -150,  -30, 150,  30];  


% charge      = [-1 -1 +1 +1 -1 -1 +1 +1];
% grouped     = [1 2 3 4; 5 6 7 8];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2,  1.2,  1.2, 1.2, 1.2;...  
%                -150,  -30, 150,  30,   90,  90,  90,  90;...    
%                  90,   90,  90,  90, -150, -30, 150,  30];  

             
% charge      = [-1 -1 +1 +1 +1 +1];
% grouped     = [1 3 4; 2 5 6];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2,  1.2,  1.2;...  % radius 
%                 -90,   90, 150,  30, -150,  -30;...  % phi    (xy coordinate)
%                 -90,   -90,  -90,  -90,  -90,  -90]; % theta   from z -axis
            

% charge      = [-1 -1 +1 +1 +1 +1];
% grouped     = [1 3 4; 2 5 6];
% coorInfo    = [ 1.3,  1.3, 1.3, 1.3,  1.3,  1.3;...  % radius 
%                 -90,   90, 150,  30, -90,  -90;...   % phi    (xy coordinate)
%                 -90,   -90,  -90,  -90, -150,  -30]; % theta   from z -axis
% dim = 'z'; % removed dimension

% charge      = [+1 -1 +1, +1 -1 +1, -1 +1 -1, -1 +1 -1];
% grouped     = [1 2 3 7 8 9; 4 5 6 10 11 12];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2, 1.2,  1.2, 1.2, 1.2, 1.2,  1.2, 1.2, 1.2;...  % radius 
%                -153, -150, -147, -33, -30, -27, 153, 150, 147, 33, 30, 27;...  % alpha (xy coordinate)
%                 90,   90,   90,   90,  90,  90,  90,  90,  90, 90, 90, 90];


%% display the figures in the paper (with z components)

% figure 1
% charge      = [-1 -1 +1 +1];
% grouped     = [1 3; 2 4];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2;...  % radius 
%                -170,  -10, 140,  40;...  % alpha (xy coordinate)
%                 90,   90,  90,  90];

% paper result - DONT FORGET make x dimension 0!
% charge      = [-1 -1 +1 +1];
% grouped     = [1 3; 2 4];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2;...  % radius 
%                -170,  -10, 140,  40;...  % alpha (xy coordinate)
%                 90,   90,  90,  90];
% dim = 'x';

% % rotated
% charge      = [-1 -1 +1 +1];
% grouped     = [1 3; 2 4];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2;...  % radius 
%                  90,   90,  90,  90;...  % alpha (xy coordinate)
%                -170,  -10, 140,  40];
% dim = 'z';


% figure 2A
% charge      = [-1 -1 +1 +1];
% grouped     = [1 3; 2 4];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2;...  % radius 
%                -110,  -70, 170,  10;...  % alpha (xy coordinate)
%                 90,   90,  90,  90];
% dim = 'y';

% rotated
% charge      = [-1 -1 +1 +1];
% grouped     = [1 3; 2 4];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2;...  % radius 
%                  90,   90,  90,  90;...  % alpha (xy coordinate)
%                -110,  -70, 170,  10];
% dim = 'y';

% % figure 2B
% charge      = [-1 -1 +1 +1];
% grouped     = [1 3; 2 4];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2;...  % radius 
%                -130,  -50, 170,  10;...  % alpha (xy coordinate)
%                 90,   90,  90,  90];
% dim = 'y';

% % rotated
% charge      = [-1 -1 +1 +1];
% grouped     = [1 3; 2 4];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2;...  % radius 
%                  90,   90,  90,  90;...  % alpha (xy coordinate)
%                -130,  -50, 170,  10];
% dim = 'y';


% figure 2C
% charge      = [-1 -1 +1 +1];
% grouped     = [1 3; 2 4];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2;...  % radius 
%                -170,  -10, 170,  10;...  % alpha (xy coordinate)
%                 90,   90,  90,  90];
% dim = 'y';

% % rotated
% charge      = [-1 -1 +1 +1];
% grouped     = [1 3; 2 4];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2;...  % radius 
%                  90,   90,  90,  90;...  % alpha (xy coordinate)
%                -170,  -10, 170,  10];
% dim = 'z';


% figure 2D
% charge      = [-1 -1*2.5 +1 +1*2.5];
% grouped     = [1 3; 2 4];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2;...  % radius 
%                -170,  -10, 170,  10;...  % alpha (xy coordinate)
%                 90,   90,  90,  90];
% dim = 'x';

% % rotated
% charge      = [-1 -1*2.5 +1 +1*2.5];
% grouped     = [1 3; 2 4];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2;...  % radius 
%                  90,   90,  90,  90;...  % alpha (xy coordinate)
%                -170,  -10, 170,  10];
% dim = 'y';

%% monopole, dipole, tetrapole, and more
% 
% % dipole
% charge      = [-1 +1 -1 +1];
% grouped     = [1 4; 3 2];
% coorInfo    = [ 12,  12, 12, 12;...  % radius 
%                -175,  -185, -5,  +5;...   % alpha (xy coordinate)
%                 90,   90,  90,  90];

% % dipole rotated
% charge      = [-1 +1 -1 +1];
% grouped     = [1 2; 3 4];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2;...  % radius 
%                90,   90,  90,  90;...  % alpha (xy coordinate)
%                -175,  -185, 5,  -5];

% % dipole - opened up
charge      = [-1 +1 -1 +1];
grouped     = [1 2; 3 4];
coorInfo    = [ 12,  12, 12, 12;...  % radius 
               -135,  135, -45,  +45;...   % alpha (xy coordinate)
                90,   90,  90,  90];

% tripole
% charge      = [-1 +1 -1, -1 +1 -1];
% grouped     = [1 2 3; 4 5 6];
% coorInfo    = [ 12,  12, 12, 12, 12, 12;...  % radius 
%                -175, -180,  -185,   5,   0  -5;...  % alpha (xy coordinate)
%                  90,   90,    90,  90,  90, 90];

% % tripole Rotated
% charge      = [-1 +1 -1, -1 +1 -1];
% grouped     = [1 2 3; 4 5 6];
% coorInfo    = [ 1.2,  1.2, 1.2, 1.2, 1.2, 1.2;...  % radius 
%                90,   90,    90,  90,  90, 90;...  % alpha (xy coordinate)
%              -175, -180,  -185,   5,   0  -5];


% tripole - opened up (Excellent!!)
% charge      = [-1 +1 -1, -1 +1 -1];
% grouped     = [1 2 3; 4 5 6];
% coorInfo    = [ 12,  12, 12, 12, 12, 12;...  % radius 
%                -171.5, -180,  171.5,   8.5,   0  -8.5;...  % alpha (xy coordinate)
%                  90,   90,    90,  90,  90, 90];
             

% pentapole (HD)
% charge      = [-1 -1 +1 -1 -1, -1 -1 +1 -1 -1].*0.25;
% grouped     = [1 2 3 4 5; 6 7 8 9 10];
% coorInfo    = [1.2, 1.2,  1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2;...  % radius 
%                -180, -175, -180,  -185, -180,  0,  5,   0, -5, 0;...  % alpha (xy coordinate)
%                  95,   90,   90,    90,   85, 95, 90,  90, 90, 85];

% pentapole (HD) rotated
% charge      = [-1 -1 +1 -1 -1, -1 -1 +1 -1 -1].*0.25;
% grouped     = [1 2 3 4 5; 6 7 8 9 10];
% coorInfo    = [1.2, 1.2,  1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2;...  % radius 
%                95,   90,   90,    90,   85, 95, 90,  90, 90, 85;...  % alpha (xy coordinate)
%                -180, -175, -180,  -185, -180,  0,  5,   0, -5, 0;];

%% Exploring the result of Buzasky paper (monopole) 

% -45 degrees
% charge      = [-1 +1 -1 +1];
% grouped     = [1 2;3 4];
% coorInfo    = [  12, 12, 12, 12;...  % radius 
%                 135, -45,  -185, -5;...  % alpha (xy coordinate)
%                  90, 90, 90, 90];
             
% % 0 degrees             
% charge      = [-1 +1 -1 +1];
% grouped     = [1 2;3 4];
% coorInfo    = [  12, 12, 12, 12;...  % radius 
%                  180, 0,  -185, -5;...  % alpha (xy coordinate)
%                  90, 90, 90, 90];             
 
% % 45 degrees             
% charge      = [-1 +1 -1 +1];
% grouped     = [1 2;3 4];
% coorInfo    = [  12, 12, 12, 12;...  % radius 
%                  -135, 45,  -185, -5;...  % alpha (xy coordinate)
%                  90, 90, 90, 90];

%% dipole witth rotation

% 0 degres
% charge      = [-1 +1 -1 +1];
% grouped     = [1 2; 3 4];
% coorInfo    = [  12, 12, 12, 12;...  % radius 
%                 210,  150, -30,  30;...  % alpha (xy coordinate)
%                  90, 90, 90, 90];

% -45 degrees             
% charge      = [-1 +1 -1 +1];
% grouped     = [1 2; 3 4];
% coorInfo    = [  12, 12, 12, 12;...  % radius 
%                 150,  210, -30,  30;...  % alpha (xy coordinate)
%                  135, 135, 45, 45];

% +45 degrees              
% charge      = [-1 +1 -1 +1];
% grouped     = [1 2; 3 4];
% coorInfo    = [  12, 12, 12, 12;...  % radius 
%                 150,  210, -30,  30;...  % alpha (xy coordinate)
%                  45, 45, 135, 135];
             
% +90 degrees                
% charge      = [-1 +1 -1 +1];
% grouped     = [1 2; 3 4];
% coorInfo    = [ 12,  12,  12, 12;...  % radius
%                 90,  90,  90, 90;...  % alpha (xy coordinate)
%                185,  175, -5,  5];

             
%% Run the simulation
visGraphAnat( charge, grouped, coorInfo, dim );