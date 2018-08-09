function [ coor ] = genCoor( coorInfo, center )

coor = zeros(3, size(coorInfo,2)); % 3 dimensions X number of electrodes

for i = 1:size(coorInfo,2)
    coor(:,i) = [coorInfo(1,i)*sind(coorInfo(3,i))*cosd(coorInfo(2,i))+center(1),...
                 coorInfo(1,i)*sind(coorInfo(3,i))*sind(coorInfo(2,i))+center(2),...
                 coorInfo(1,i)*cosd(coorInfo(3,i))+center(3)];
end

end

