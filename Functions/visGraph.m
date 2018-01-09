function [ ] = visGraph( charge, grouped, coorInfo )

% This code is the first version in completing a proper code for the
% analytical analysis of the stimulation, using a point charge.

% the plan is:

% 1) use a function to generate a spherical grid
% 2) insert the charges with their amplitude, in a vector. e.g.: [-1 -1 +2 +1];
% 3) state which ones you would like to couple together. e.g., [1 3;2 4];
% NOTE: the number of elements in coupled mat must be same as charge vector
% 4) insert the position of the electrode: either in rad or deg

% tic
sq = @squeeze;

%% Generate spherical grid

n=101;                      % number of points that you want
radius = 1;                 % radius of the circle
radiusRes = 0.02;
center = [0 ,0, 0];

[x, y ,z] = sphereGrid(radius, radiusRes, n, center);

% display the grid
% scatter3(x, y, z, ones(size(z))); hold on;
% xlabel('X'); ylabel('Y'); zlabel('Z');
% axis vis3d
% axis off

%% Compute the coordinates, based on given information

coor       = genCoor(coorInfo, center);

% Note that you could also ignore the coordinate generator and insert the
% x, y, and z coordinates directly

%% plot the eletrodes relative to grid

% the grid
figure; hold on;
scatter3(x, y, z, ones(size(z))); hold on;
xlabel('X'); ylabel('Y'); zlabel('Z'); axis vis3d

% set color for the elctrodes (-ve: blue, +ve: red)
col           = zeros(size(charge)); 
chrg          = charge./abs(charge);
col(chrg==-1) = 'b';
col(chrg==+1) = 'r';
col           = char(col);

% the electrodes
plotCoor( coor, col ); axis vis3d

title('meshgrid with elctrodes');

%% Compute the electric field

eFieldVec  = zeros(3, numel(x), numel(charge));

for i = 1:numel(charge)
    [eFieldVec(1,:,i), eFieldVec(2,:,i), eFieldVec(3,:,i)] = eField(charge(i), coor(:,i), x, y, z);
end

%% combine the electric fields

eFieldComb = zeros(3, size(eFieldVec,2), size(grouped,1));

for i = 1:size(grouped,1)
    eFieldComb(:,:,i) = sum(eFieldVec(:,:, grouped(i,:)),3);
end

%% plot the Electric Field with respect to electrodes

colorList = 'rbgkmcyw';
color     = repmat(colorList,1,ceil(size(grouped,1)/numel(colorList)));

figure; hold on;
plotCoor( coor, col );
for i = 1:size(grouped,1)
    quiver3(x', y', z', eFieldComb(1,:,i),  eFieldComb(2,:,i),  eFieldComb(3,:,i),  4, color(i));
%     quiver3(x(z==0)', y(z==0)', z(z==0)', eFieldComb(1,z==0,i),  eFieldComb(2,z==0,i),  eFieldComb(3,z==0,i),  4, color(i));
%     quiver3(x(x==0)', y(x==0)', z(x==0)', eFieldComb(1,x==0,i),  eFieldComb(2,x==0,i),  eFieldComb(3,x==0,i),  4, color(i));
    axis vis3d
end
title('3D electric field');
hold off;

figure; hold on;
plotCoor( coor, col );
for i = 1:size(grouped,1)
%     quiver3(x', y', z', eFieldComb(1,:,i),  eFieldComb(2,:,i),  eFieldComb(3,:,i),  4, col(i));
    quiver3(x(z==0)', y(z==0)', z(z==0)', eFieldComb(1,z==0,i),  eFieldComb(2,z==0,i),  eFieldComb(3,z==0,i),  4, color(i), 'AutoScale','off');
    quiver3(x(x==0)', y(x==0)', z(x==0)', eFieldComb(1,x==0,i),  eFieldComb(2,x==0,i),  eFieldComb(3,x==0,i),  4, color(i), 'AutoScale','off');
    axis vis3d
end
title('2D electric field (Z=0)');
hold off;

%% Compute the amplitudes

% remove a dimension;
% remove x

% eFieldComb(1,:,:) = 0;

eFieldSum      = sum(eFieldComb,3);
eFieldDiff     = diff(eFieldComb,[],3);
eFieldSum_amp  = sqrt(sum((eFieldSum.^2),1));
eFieldDiff_amp = sqrt(sum((eFieldDiff.^2),1));

eFieldAM_amp   = abs(eFieldSum_amp - eFieldDiff_amp);
eFieldComb_amp = sq(sqrt(sum((eFieldComb.^2),1)))'; 


%% plot the data with electrodes
figure; 

line = 0;

tri = delaunay(x(z==0),y(z==0));

subplot(242); 
trisurf(tri, x(z==0), y(z==0), eFieldAM_amp(z==0).*0, eFieldAM_amp(z==0)); hold on;
plot([min(x(z==0 & y==line)) max(x(z==0 & y==line))], [line line], 'r:', 'LineWidth', 1);
plot([line line], [min(y(z==0 & x==line)) max(y(z==0 & x==line))], 'r:', 'LineWidth', 1);
plotCoor( coor, col );
shading interp; view(0,90); h = colorbar; ylabel(h, 'Modulation Amplitude'); axis vis3d

subplot(241); 
trisurf(tri, x(z==0), y(z==0), eFieldAM_amp(z==0).*0, eFieldComb_amp(1,z==0)); hold on;
plot([min(x(z==0 & y==line)) max(x(z==0 & y==line))], [line line], 'r:', 'LineWidth', 1);
plot([line line], [min(y(z==0 & x==line)) max(y(z==0 & x==line))], 'r:', 'LineWidth', 1);
plotCoor( coor, col );
shading interp; view(0,90); h = colorbar; ylabel(h, 'eField Amplitude'); axis vis3d

subplot(243); 
trisurf(tri, x(z==0), y(z==0), eFieldAM_amp(z==0).*0, eFieldComb_amp(2,z==0)); hold on;
plot([min(x(z==0 & y==line)) max(x(z==0 & y==line))], [line line], 'r:', 'LineWidth', 1);
plot([line line], [min(y(z==0 & x==line)) max(y(z==0 & x==line))], 'r:', 'LineWidth', 1);
plotCoor( coor, col );
shading interp; view(0,90); h = colorbar; ylabel(h, 'eField Amplitude'); axis vis3d


subplot(2,4,[5,6,7]); hold on;
scatter(x(z==0 & y==line), eFieldAM_amp(z==0 & y==line), 'filled');
scatter(x(z==0 & y==line), eFieldComb_amp(1, z==0 & y==line), 'filled');
scatter(x(z==0 & y==line), eFieldComb_amp(2, z==0 & y==line), 'filled');
xlabel('X'); ylabel('Electric Field (N/C)'); grid;
legend('E-field modulation amplutide', 'Left Electrode E-field', 'Right Electrode E-field')
legend('Location','north')

subplot(2,4,[4,8]); hold on;
scatter(eFieldAM_amp(z==0 & x==line), y(z==0 & x==line), 'filled');
scatter(eFieldComb_amp(1, z==0 & x==line), y(z==0 & x==line), 'filled');
scatter(eFieldComb_amp(2, z==0 & x==line), y(z==0 & x==line), 'filled');
xlabel('Electric Field (N/C)'); ylabel('Y'); grid;
set(gca,'XAxisLocation','bottom','xdir','reverse','YAxisLocation','right');


%%
% toc

end

