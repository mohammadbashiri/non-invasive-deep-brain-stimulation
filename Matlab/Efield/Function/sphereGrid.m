function [ x, y, z ] = sphereGrid( radius, radiusRes, n, center )

% radius        -> the radius of the biggest sphere
% radiusRes     -> the difference between the radius of adjacent spheres
% n             -> number of samples in one circle
% center        -> center coordinate of the sphere

%%

a  = linspace(0,2*pi,n);
b  = linspace(0,pi,n/2+0.5);
[phi, theta] = meshgrid(a, b);

Xcirc = zeros((radius/radiusRes)+1,numel(a)*numel(b));
Ycirc = zeros((radius/radiusRes)+1,numel(a)*numel(b));
Zcirc = zeros((radius/radiusRes)+1,numel(a)*numel(b));

counter = 1;
for r=0:radiusRes:radius
    x = r * sin(phi) .* cos(theta);
    y = r * sin(phi) .* sin(theta);
    z = r * cos(phi);

    Xcirc(counter,:) = x(:);
    Ycirc(counter,:) = y(:);
    Zcirc(counter,:) = z(:);
    counter = counter + 1;
end

x = Xcirc(:) + center(1);
y = Ycirc(:) + center(2);
z = Zcirc(:) + center(3);

x = round(x,4);
y = round(y,4);
z = round(z,4);

grid_val = [x'; y'; z']';
grid_val = unique(grid_val, 'rows');
x = grid_val(:,1);
y = grid_val(:,2);
z = grid_val(:,3);

end

