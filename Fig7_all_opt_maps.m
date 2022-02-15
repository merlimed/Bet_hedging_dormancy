%stoch_temp = zeros(n_env, n_k, n_delays, 2);
clc
clear
load 'stoch_opt_refined.mat'
%%

delays = [0, 1, 2, 4, 6, 8, 10];
env_mu = [2, 4, 6, 8, 10, 20];
xvalues = {'0','1','2', '4', '6', '8','10'};
yvalues = {'2','4','6','8', '10', '20'};
%%
c = colormap('summer');
my_c = zeros(100, 3);
my_c(1:50, :) = c(1:4:200,:);
my_c(50:100, :) = c(200:250,:);
my_c(1,:) = [0 0.4 0.3]; % color of 0
size(my_c)
%%
figure('Position', [0 300 2000 350])
k_ind = 1;
xy_ind = 2;
colorbar_lim = [0 .5];
stoch_temp = stoch_temp_new;
subplot(1,4,1)
temp = reshape(stoch_temp(:, k_ind,:,xy_ind), [6, 7]);
h1 = heatmap(xvalues, yvalues, temp, 'ColorMap', my_c);
h1.YDisplayData=flip(h1.YDisplayData);
h1.XLabel = 'Delay n';
h1.YLabel = 'Average environmental times \tau';
h1.Title = 'm = 1';
set(gca, 'FontSize', 16)
h1.ColorLimits = colorbar_lim;
h1.ColorbarVisible = 'off';

subplot(1,4,2);
k_ind = 2;
temp = reshape(stoch_temp(:, k_ind,:,xy_ind), [6, 7]);
h2 = heatmap(xvalues, yvalues, temp, 'ColorMap', my_c, 'MissingDataColor',[1 1 1]);
h2.YDisplayData=flip(h2.YDisplayData);
h2.XLabel = 'Delay n';
h2.Title = 'm = 2';
set(gca, 'FontSize', 16)
h2.ColorLimits = colorbar_lim;
h2.ColorbarVisible = 'off';


subplot(1,4,3);
k_ind = 3;
temp = reshape(stoch_temp(:, k_ind,:,xy_ind), [6, 7]);
h3 = heatmap(xvalues, yvalues, temp, 'ColorMap', my_c, 'MissingDataColor',[1 1 1]);
h3.YDisplayData=flip(h3.YDisplayData);
h3.XLabel = 'Delay n';
h3.Title = 'm = max-2';
set(gca, 'FontSize', 16)
h3.ColorLimits = colorbar_lim;
h3.ColorbarVisible = 'off';


subplot(1,4,4);
k_ind = 4;
temp = reshape(stoch_temp(:, k_ind,:,xy_ind), [6, 7]);
h4 = heatmap(xvalues, yvalues, temp, 'ColorMap', my_c, 'MissingDataColor',[1 1 1]...
    , 'MissingDataLabel', 'unfeasible');
h4.YDisplayData=flip(h4.YDisplayData);
h4.XLabel = 'Delay n';
h4.Title = 'm = max-1';
set(gca, 'FontSize', 16)
h4.ColorLimits = colorbar_lim;
axs = struct(h4); %ignore warning that this should be avoided
cbh = axs.Colorbar;
set(cbh, 'YTick', [0, 0.2, .4, .6, .8, 1], ...
    'YTickLabel', {'0', '0.2', '0.4', '0.6','0.8', '1'})
ax1 = findobj(h1.NodeChildren, 'Type','Axes');
ax2 = findobj(h2.NodeChildren, 'Type','Axes');
ax3 = findobj(h3.NodeChildren, 'Type','Axes');
ax4 = findobj(h4.NodeChildren, 'Type','Axes');

linkaxes([ax1,ax2, ax3, ax4],'y');
yticklabels(ax2,{})
yticklabels(ax3,{})
yticklabels(ax4,{})

%{ 
old map
mymap = [   0.3160, 0.5740, 0.1;
            0.4360, 0.6440, 0.095;
            0.5560, 0.7140, 0.09;
            0.6760, 0.7840, 0.085;
            0.7760, 0.8540, 0.08;
            0.8060, 0.8740, 0.075;
            0.8360, 0.9040, 0.07;
            0.8660, 0.9040, 0.065;
            0.8960, 0.9040, 0.06;
            0.9260, 0.9040, 0.055;
            0.9590, 0.9040, 0.05;
            ];
%}


