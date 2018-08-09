function [] = plotCoor( coor, col )
%PLOTCOOR Summary of this function goes here
%   Detailed explanation goes here
for i = 1:size(coor,2)
    scatter3(coor(1,i), coor(2,i), coor(3,i), 50, col(i), 'filled');
    view(0,90);
    xlabel('X'); ylabel('Y'); zlabel('Z');
    axis vis3d
end

end

