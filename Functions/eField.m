function [ u, v, w ] = eField( charge, elecCoor, x, y, z )
%EFIELD Summary of this function goes here
%   Detailed explanation goes here
rQube = ((((x-elecCoor(1)).^2+(y-elecCoor(2)).^2+(z-elecCoor(3)).^2)).^1.5);

u = charge./rQube.*(x-elecCoor(1));
v = charge./rQube.*(y-elecCoor(2));
w = charge./rQube.*(z-elecCoor(3));

end

