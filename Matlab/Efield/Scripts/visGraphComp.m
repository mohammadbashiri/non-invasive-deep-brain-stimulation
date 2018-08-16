% This code is the first version in completing a proper code for the
% computational analysis of the stimulation, using Comsol data.

% the plan is:

% 1) use the arrow data to compute the modulation amplitude
% 2) include the amplitude of the eFields;
% 3) 
% NOTE: the number of elements in coupled mat must be same as charge vector
% 4) insert the position of the electrode: either in rad or deg

close all

% tic
sq = @squeeze;

%% plot the eField in 3D

eFieldComb = zeros(3, numel(VectorX_left), 2); % (coordinate x datapoints x electrode group)
eFieldComb(:,:,1) = [VectorX_left';VectorY_left';VectorZ_left'];
eFieldComb(:,:,2) = [VectorX_right';VectorY_right';VectorZ_right'];

colorList = 'rbgkmcyw';
color     = repmat(colorList,1,ceil(size(eFieldComb,3)/numel(colorList)));

figure; hold on;
for i = 1:size(eFieldComb,3)
    quiver3(x', y', z', eFieldComb(1,:,i),  eFieldComb(2,:,i),  eFieldComb(3,:,i),  4, color(i));
%     quiver3(x(z==0)', y(z==0)', z(z==0)', eFieldComb(1,z==0,i),  eFieldComb(2,z==0,i),  eFieldComb(3,z==0,i),  4, color(i));
%     quiver3(x(x==0)', y(x==0)', z(x==0)', eFieldComb(1,x==0,i),  eFieldComb(2,x==0,i),  eFieldComb(3,x==0,i),  4, color(i));
    axis vis3d
end
title('3D electric field');
xlabel('X'); ylabel('Y'); zlabel('Z');
hold off;

%% Plot the eFields in 2D

% First we have to compute the available values for each 
xUniq = unique(x);
yUniq = unique(y);
zUniq = unique(z);

% set the slice number in y direction
sliceNo = ceil(numel(yUniq)/2) + 0;

%%
figure; hold on;
% plotCoor( coor, col );
scatter3(x, y, z, ones(size(z))); hold on;
for i = 1:size(eFieldComb,3)
%     quiver3(x', y', z', eFieldComb(1,:,i),  eFieldComb(2,:,i),  eFieldComb(3,:,i),  4, col(i));
%     quiver3(x(z==zUniq(sliceNo))', y(z==zUniq(sliceNo))', z(z==zUniq(sliceNo))', eFieldComb(1,z==zUniq(sliceNo),i),  eFieldComb(2,z==zUniq(sliceNo),i),  eFieldComb(3,z==zUniq(sliceNo),i),  4, color(i), 'AutoScale','off');
    quiver3(x(z==zUniq(sliceNo))', y(z==zUniq(sliceNo))', z(z==zUniq(sliceNo))', eFieldComb(1,z==zUniq(sliceNo),i),  eFieldComb(2,z==zUniq(sliceNo),i),  eFieldComb(3,z==zUniq(sliceNo),i),  1, color(i), 'AutoScale','off');
    axis vis3d
end
title('2D electric field (Z=0)');
xlabel('X'); ylabel('Y'); zlabel('Z');
hold off;

%% Compute the amplitudes

% choose the dimension to be removed
dim = '-';

% remove a dimension;
if (dim == 'x')
        eFieldComb(1,:,:) = 0; % remove x
elseif (dim == 'y')
        eFieldComb(2,:,:) = 0; % remove x
elseif (dim == 'z')
        eFieldComb(3,:,:) = 0; % remove x
end

eFieldSum      = sum(eFieldComb,3);
eFieldDiff     = diff(eFieldComb,[],3);
eFieldSum_amp  = sqrt(sum((eFieldSum.^2),1));
eFieldDiff_amp = sqrt(sum((eFieldDiff.^2),1));

eFieldAM_amp   = abs(eFieldSum_amp - eFieldDiff_amp);
eFieldComb_amp = sq(sqrt(sum((eFieldComb.^2),1)))'; 

%% plot the data with electrodes
figure; 

line = ceil(numel(yUniq)/2); % set the slice number in z direction
triXY = delaunay(x(z==zUniq(sliceNo)),y(z==zUniq(sliceNo)));

subplot(242); 
% figure;
trisurf(triXY, x(z==zUniq(sliceNo)),y(z==zUniq(sliceNo)), eFieldAM_amp(z==zUniq(sliceNo)).*0, eFieldAM_amp(z==zUniq(sliceNo))); hold on;
plot([min(x(y==yUniq(sliceNo) & z==zUniq(line))) max(x(y==yUniq(sliceNo) & z==zUniq(line)))], [yUniq(sliceNo) yUniq(sliceNo)], 'r:', 'LineWidth', 1);
plot([xUniq(line) xUniq(line)], [min(y(z==zUniq(sliceNo) & x==xUniq(line))) max(y(z==zUniq(sliceNo) & x==xUniq(line)))], 'r:', 'LineWidth', 1);
axis tight equal
shading interp; view(0,90); h = colorbar; ylabel(h, {'Modulation Amplitude', '(Normalized)'}); axis vis3d;
h.Location = 'northoutside'; h.AxisLocation = 'out';

subplot(241); 
trisurf(triXY, x(z==zUniq(sliceNo)),y(z==zUniq(sliceNo)), eFieldAM_amp(z==zUniq(sliceNo)).*0, eFieldComb_amp(1,z==zUniq(sliceNo))); hold on;
plot([min(x(y==yUniq(sliceNo) & z==zUniq(line))) max(x(y==yUniq(sliceNo) & z==zUniq(line)))], [yUniq(sliceNo) yUniq(sliceNo)], 'r:', 'LineWidth', 1);
plot([xUniq(line) xUniq(line)], [min(y(z==zUniq(sliceNo) & x==xUniq(line))) max(y(z==zUniq(sliceNo) & x==xUniq(line)))], 'r:', 'LineWidth', 1);
axis tight equal
shading interp; view(0,90); h = colorbar; ylabel(h, {'eField Amplitude', '(Normalized)'}); axis vis3d
h.Location = 'northoutside'; h.AxisLocation = 'out';

subplot(243); 
trisurf(triXY, x(z==zUniq(sliceNo)),y(z==zUniq(sliceNo)), eFieldAM_amp(z==zUniq(sliceNo)).*0, eFieldComb_amp(2,z==zUniq(sliceNo))); hold on;
plot([min(x(y==yUniq(sliceNo) & z==zUniq(line) )) max(x(y==yUniq(sliceNo) & z==zUniq(line)))], [yUniq(sliceNo) yUniq(sliceNo)], 'r:', 'LineWidth', 1);
plot([xUniq(line) xUniq(line)], [min(y(z==zUniq(sliceNo) & x==xUniq(line))) max(y(z==zUniq(sliceNo) & x==xUniq(line)))], 'r:', 'LineWidth', 1);
axis tight equal
shading interp; view(0,90); h = colorbar; ylabel(h, 'eField Amplitude'); axis vis3d
h.Location = 'northoutside'; h.AxisLocation = 'out';

subplot(2,4,[5,6,7]); hold on;
% scatter(x(y==yUniq(sliceNo) & z==zUniq(line)), eFieldAM_amp(y==yUniq(sliceNo) & z==zUniq(line)), 'filled');
plot(x(y==yUniq(sliceNo) & z==zUniq(line)), eFieldAM_amp(y==yUniq(sliceNo) & z==zUniq(line)), 'LineWidth', 2);
plot(x(y==yUniq(sliceNo) & z==zUniq(line)), eFieldComb_amp(1, y==yUniq(sliceNo) & z==zUniq(line)), 'LineWidth', 2);
plot(x(y==yUniq(sliceNo) & z==zUniq(line)), eFieldComb_amp(2, y==yUniq(sliceNo) & z==zUniq(line)), 'LineWidth', 2);
xlabel('X'); ylabel('Electric Field (N/C)'); grid;
legend('E-field modulation amplutide', 'Left Electrode E-field', 'Right Electrode E-field')
legend('Location','north')

subplot(2,4,[4,8]); hold on;
plot(eFieldAM_amp(x==xUniq(sliceNo) & z==zUniq(line)), y(x==xUniq(sliceNo) & z==zUniq(line)), 'LineWidth', 2);
plot(eFieldComb_amp(1, z==zUniq(sliceNo) & x==xUniq(line)), y(z==zUniq(sliceNo) & x==xUniq(line)), 'LineWidth', 2);
plot(eFieldComb_amp(2, z==zUniq(sliceNo) & x==xUniq(line)), y(z==zUniq(sliceNo) & x==xUniq(line)), 'LineWidth', 2);
xlabel('Electric Field (N/C)'); ylabel('Y'); grid;
set(gca,'XAxisLocation','bottom','xdir','reverse','YAxisLocation','right');


%% Display the volume with modulation amplitude
figure;
s = 100*ones(1,numel(eFieldAM_amp));
scatter3(x, y, z, s, eFieldAM_amp, '.');
title('Modulation Amplitude');
rotate3d on;
axis vis3d

%% Display slice-by-slice
% for i = 1:numel(zUniq)
%     figure; hold on
%     s = 1*ones(1,numel(eFieldAM_amp));
%     scatter3(x, y, z, s, eFieldAM_amp, 'MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.1);
%     
%     s = 200*ones(1,numel(eFieldAM_amp));
%     scatter3(x(y==yUniq(i)), y(y==yUniq(i)), z(y==yUniq(i)), s(y==yUniq(i)), eFieldAM_amp(y==yUniq(i)), '.');
%     
%     title('Modulation Amplitude');
%     rotate3d on;
%     axis vis3d
%     view(230,30);
% end

% toc