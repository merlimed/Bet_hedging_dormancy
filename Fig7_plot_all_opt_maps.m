% We plot 4 maps for optimal switching, each for a different value of kappa
% which we computed from find_optmal_stoch and refine_opt_stoch
clc
clear
load 'Data/stoch_opt.mat'
%%
xvalues = {'0', '1', '2', '4', '6', '8', '10'}; %delay values
yvalues = {'2', '4', '6', '8', '10', '20'}; % tau values
%% Define colormap
c = colormap('summer');
my_c = zeros(100, 3);
my_c(1:50, :) = c(1:4:200, :);
my_c(50:100, :) = c(200:250, :);
my_c(1,:) = [0 0.4 0.3]; % color of 0
%%
figure('Position', [82,328,1532,290])
x_ind = 1;
y_ind = 2;
colorbar_lim = [0 .5];
%stoch_temp = stoch_temp_new;

hAxis(1) = subplot(1,4,1);
pos = get(hAxis(1), 'Position' );
pos(1) = pos(1) - 0.05; % Shift left
set(hAxis(1), 'Position', pos);
k_ind = 1;
temp_x = reshape(stoch_temp(:, k_ind, :, x_ind), [6, 7]);
temp_y = reshape(stoch_temp(:, k_ind, :, y_ind), [6, 7]);
to_plot = temp_x;
h1 = heatmap(xvalues, yvalues, to_plot, 'ColorMap', my_c);
h1.YDisplayData=flip(h1.YDisplayData);
h1.XLabel = 'Delay n';

xlabel('Delay n');
h1.YLabel = 'Mean residence time \tau';
h1.Title = '\kappa = 1';
set(gca, 'FontSize', 16)
h1.ColorLimits = colorbar_lim;
h1.ColorbarVisible = 'off';
v = get(gca,'Position');
set(gca,'Position',[v(1) v(2)*1.5 v(3:4)])

hAxis(2) = subplot(1,4,2);
pos = get(hAxis(2), 'Position');
pos(1) = pos(1) - 0.07; % Shift left
set(hAxis(2), 'Position', pos);
k_ind = 2;
temp_x = reshape(stoch_temp(:, k_ind, :, x_ind), [6, 7]);
temp_y = reshape(stoch_temp(:, k_ind, :, y_ind), [6, 7]);
to_plot = temp_x;
h2 = heatmap(xvalues, yvalues, to_plot, 'ColorMap', my_c, 'MissingDataColor',[1 1 1]);
h2.YDisplayData=flip(h2.YDisplayData);
h2.XLabel = 'Delay n';
h2.Title = '\kappa = 2';
set(gca, 'FontSize', 16)
h2.ColorLimits = colorbar_lim;
h2.ColorbarVisible = 'off';
v = get(gca,'Position');
set(gca,'Position',[v(1) v(2)*1.5 v(3:4)])

hAxis(3) = subplot(1,4,3);
pos = get(hAxis(3), 'Position' );
pos(1) = pos(1) - 0.09; % Shift left
set(hAxis(3), 'Position', pos);
k_ind = 3;
temp_x = reshape(stoch_temp(:, k_ind, :, x_ind), [6, 7]);
temp_y = reshape(stoch_temp(:, k_ind, :, y_ind), [6, 7]);
to_plot = temp_x;
h3 = heatmap(xvalues, yvalues, to_plot, 'ColorMap', my_c, 'MissingDataColor',[1 1 1]);
h3.YDisplayData=flip(h3.YDisplayData);
h3.XLabel = 'Delay n';
h3.Title = '\kappa = max-2';
set(gca, 'FontSize', 16)
h3.ColorLimits = colorbar_lim;
h3.ColorbarVisible = 'off';
v = get(gca,'Position');
set(gca,'Position',[v(1) v(2)*1.5 v(3:4)])

hAxis(4) = subplot(1,4,4);
pos = get(hAxis(4), 'Position' );
pos(1) = pos(1) - 0.11; % Shift left
set(hAxis(4), 'Position', pos);
k_ind = 4;
temp_x = reshape(stoch_temp(:, k_ind, :, x_ind), [6, 7]);
temp_y = reshape(stoch_temp(:, k_ind, :, y_ind), [6, 7]);
to_plot = temp_x;
h4 = heatmap(xvalues, yvalues, to_plot, 'ColorMap', my_c, 'MissingDataColor',[1 1 1]...
    , 'MissingDataLabel', 'unfeasible');
h4.YDisplayData=flip(h4.YDisplayData);
h4.XLabel = 'Delay n';
h4.Title = '\kappa = max-1';
set(gca, 'FontSize', 16)
h4.ColorLimits = colorbar_lim;
axs = struct(h4); %ignore warning that this should be avoided
cbh = axs.Colorbar;
set(cbh, 'YTick', [0, 0.2, .4, .6, .8, 1], ...
    'YTickLabel', {'0', '0.2', '0.4', '0.6','0.8', '1'})

v = get(gca,'Position');
set(gca,'Position',[v(1) v(2)*1.5 v(3:4)])
%%
figure('Position', [82,328,1532,290])
x_ind = 1;
y_ind = 2;
colorbar_lim = [0 .5];
stoch_temp = stoch_temp_new;

hAxis(1) = subplot(1,4,1);
pos = get(hAxis(1), 'Position' );
pos(1) = pos(1) - 0.05; % Shift left
set(hAxis(1), 'Position', pos);
k_ind = 1;
temp_x = reshape(stoch_temp(:, k_ind, :, x_ind), [6, 7]);
temp_y = reshape(stoch_temp(:, k_ind, :, y_ind), [6, 7]);
to_plot = temp_x;
h1 = heatmap(xvalues, yvalues, to_plot, 'ColorMap', my_c);
h1.YDisplayData=flip(h1.YDisplayData);
h1.XLabel = 'Delay n';

xlabel('Delay n');
h1.YLabel = 'Mean residence time \tau';
h1.Title = '\kappa = 1';
set(gca, 'FontSize', 16)
h1.ColorLimits = colorbar_lim;
h1.ColorbarVisible = 'off';


hAxis(2) = subplot(1,4,2);
pos = get(hAxis(2), 'Position');
pos(1) = pos(1) - 0.07; % Shift left
set(hAxis(2), 'Position', pos);
k_ind = 2;
temp_x = reshape(stoch_temp(:, k_ind, :, x_ind), [6, 7]);
temp_y = reshape(stoch_temp(:, k_ind, :, y_ind), [6, 7]);
to_plot = temp_x;
h2 = heatmap(xvalues, yvalues, to_plot, 'ColorMap', my_c, 'MissingDataColor',[1 1 1]);
h2.YDisplayData=flip(h2.YDisplayData);
h2.XLabel = 'Delay n';
h2.Title = '\kappa = 2';
set(gca, 'FontSize', 16)
h2.ColorLimits = colorbar_lim;
h2.ColorbarVisible = 'off';


hAxis(3) = subplot(1,4,3);
pos = get(hAxis(3), 'Position' );
pos(1) = pos(1) - 0.09; % Shift left
set(hAxis(3), 'Position', pos);
k_ind = 3;
temp_x = reshape(stoch_temp(:, k_ind, :, x_ind), [6, 7]);
temp_y = reshape(stoch_temp(:, k_ind, :, y_ind), [6, 7]);
to_plot = temp_x;
h3 = heatmap(xvalues, yvalues, to_plot, 'ColorMap', my_c, 'MissingDataColor',[1 1 1]);
h3.YDisplayData=flip(h3.YDisplayData);
h3.XLabel = 'Delay n';
h3.Title = '\kappa = max-2';
set(gca, 'FontSize', 16)
h3.ColorLimits = colorbar_lim;
h3.ColorbarVisible = 'off';

hAxis(4) = subplot(1,4,4);
pos = get(hAxis(4), 'Position' );
pos(1) = pos(1) - 0.11; % Shift left
set(hAxis(4), 'Position', pos);
k_ind = 4;
temp_x = reshape(stoch_temp(:, k_ind, :, x_ind), [6, 7]);
temp_y = reshape(stoch_temp(:, k_ind, :, y_ind), [6, 7]);
to_plot = temp_x;
h4 = heatmap(xvalues, yvalues, to_plot, 'ColorMap', my_c, 'MissingDataColor',[1 1 1]...
    , 'MissingDataLabel', 'unfeasible');
h4.YDisplayData=flip(h4.YDisplayData);
h4.XLabel = 'Delay n';
h4.Title = '\kappa = max-1';
set(gca, 'FontSize', 16)
h4.ColorLimits = colorbar_lim;
axs = struct(h4); %ignore warning that this should be avoided
cbh = axs.Colorbar;
set(cbh, 'YTick', [0, 0.2, .4, .6, .8, 1], ...
    'YTickLabel', {'0', '0.2', '0.4', '0.6','0.8', '1'})
