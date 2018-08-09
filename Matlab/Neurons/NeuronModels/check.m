a = 2;
b = 3;
global c;
c = 20;

answer = mult(a, b);


%% functions

function out = mult(a, b)
    global c;
    out = a * b * c;
end