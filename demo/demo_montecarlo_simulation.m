%% DEMO_MONTECARLO_SIMULATIONS
% Script demonstrating an example usage scenario for qMT Monte Carlo 
% simulations.
%
% On a 3.1 GHz Intel Core i5 processor, this scripts has a computation time
% of approximately 30 minutes.

clear all
close all
clc

%% Prepare tissue, fitting options, and protocol objects for Jacobian calculation
%

% Tissue object creation
T1f = 0.9; %tmp
%               F    kf  R1f    R1r T2f   T2r
tissueParams = [0.15 4.0 1./T1f 1   0.030 12.0e-06];
clear T1f
tissueObj  = SPGR_Tissue(tissueParams);

% Protocol object creation for each protocol
protocolObjs = {SPGR_Protocol('protocols/10pt_2fa_uniform.mat') ...
                SPGR_Protocol('protocols/10pt_lambda_0.mat')    ...
                SPGR_Protocol('protocols/10pt_lambda_0p5.mat')  ...
                };

% Fitting options object
fitOptsObj = SPGR_FitOpts('fitting_options/fitOpts.mat');

%% Prep Monte Carlo options
%

% Signal-to-noise ratio
SNR = 100;

% B1 error (in percentages)
b1Perc = [-25 -20 -15 -10 -5 0 5 10 15 20 25];

% Number of simulations
numSims = 100;

%% Perform Monte Carlo simulations
%

% Startup parallel processing workers
if isempty(gcp('nocreate'))
    parpool()
end

% Loop for each protocol
for ii = 1:length(protocolObjs)
    % Initialize 
    tmpMCObj=SPGR_MonteCarlo(protocolObjs{ii}, tissueObj, fitOptsObj);
    
    % Generate MT signals and add noise for each Monte Carlo simulation
    tmpMCObj.genNoisyDataset(SNR, numSims);
    
    % Loop for each B1 error
    parfor jj = 1:length(b1Perc)
        % Hard copy Monte Carlo object to a new object so that each B1Perc
        % case is fitted to the same noisy data.
        b1VFA_MCobj{ii,jj} = tmpMCObj.copy(); 

        % Add the current B1 information for this case to the Monte Carlo 
        % object. 'B1_VFA' tells the object to assume VFA T1 mapping, and
        % propagate B1 error to is
        b1VFA_MCobj{ii,jj}.prep(struct('name', 'B1_VFA', 'errorPerc', b1Perc(jj)))
        
        % Fit the Monte Carlo simulations for this protocol and B1 error.
        b1VFA_fitResults{ii, jj} = b1VFA_MCobj{ii,jj}.fit();
    end
    clear ans, clear b1VFA_MCobj % Temporary variables, bloats the saved files.
    save(['varyb1script_vfa_' num2str(numSims) 'points_' num2str(SNR) 'SNR'])
end

%% Plot Mean F vs B1 error
% Mean F (y axis) is a % calculated relative to the mean value for B1 error = 0%

for b1Index=1:length(b1Perc)
    VFA_noisy_Uniform_F(b1Index) = mean(b1VFA_fitResults{1,b1Index}.noisyDataset.F);
    VFA_noisy_CRLB_F(b1Index) = mean(b1VFA_fitResults{2,b1Index}.noisyDataset.F);
    VFA_noisy_Lambda_F(b1Index) = mean(b1VFA_fitResults{3,b1Index}.noisyDataset.F);
end


idealB1_Index = find(b1Perc == 0);

VFA_pdiff_Uniform_F = (VFA_noisy_Uniform_F-repmat(VFA_noisy_Uniform_F(idealB1_Index),size(b1Perc)))./repmat(VFA_noisy_Uniform_F(idealB1_Index),size(b1Perc)).*100;
VFA_pdiff_CRLB_F = (VFA_noisy_CRLB_F-repmat(VFA_noisy_CRLB_F(idealB1_Index),size(b1Perc)))./repmat(VFA_noisy_CRLB_F(idealB1_Index),size(b1Perc)).*100;
VFA_pdiff_Lambda_F = (VFA_noisy_Lambda_F-repmat(VFA_noisy_Lambda_F(idealB1_Index),size(b1Perc)))./repmat(VFA_noisy_Lambda_F(idealB1_Index),size(b1Perc)).*100;

structHandler.figure = figure();
plot(b1Perc, VFA_pdiff_Uniform_F(:),'-o', 'LineWidth', 2 ,'MarkerSize', 10), hold on
plot(b1Perc, VFA_pdiff_CRLB_F(:),'-o', 'LineWidth', 2 ,'MarkerSize', 10), hold on
plot(b1Perc, VFA_pdiff_Lambda_F(:),'-o', 'LineWidth', 2 ,'MarkerSize', 10), hold on


structHandler.xlabel = xlabel('B_1 error (n.u.)');
structHandler.ylabel = ylabel('deltaF error (%)');
structHandler.legend = legend({'Uniform', 'CRLB', 'Lambda'});
figureProperties_plot(structHandler)

% Add greyed out zone
Y = [1;
     1];
ar = area([-30 30], Y, -1, 'LineStyle',':');
ar.FaceAlpha = 0.1;
ar.FaceColor = 'k';
ar.ShowBaseLine = 'off';

%% Plot Standard Deviation of F vs B1 error
%

for b1Index=1:length(b1Perc)
    VFA_noisy_Uniform_F_STD(b1Index) = std(b1VFA_fitResults{1,b1Index}.noisyDataset.F);
    VFA_noisy_CRLB_F_STD(b1Index) = std(b1VFA_fitResults{2,b1Index}.noisyDataset.F);
    VFA_noisy_Lambda_F_STD(b1Index) = std(b1VFA_fitResults{3,b1Index}.noisyDataset.F);
end

structHandler.figure = figure();
plot(b1Perc, VFA_noisy_Uniform_F_STD(:),'-o', 'LineWidth', 2 ,'MarkerSize', 10), hold on
plot(b1Perc, VFA_noisy_CRLB_F_STD(:),'-o', 'LineWidth', 2 ,'MarkerSize', 10), hold on
plot(b1Perc, VFA_noisy_Lambda_F_STD(:),'-o', 'LineWidth', 2 ,'MarkerSize', 10), hold on


structHandler.xlabel = xlabel('B_1 error (n.u.)');
structHandler.ylabel = ylabel('STD F (n.u.)');
structHandler.legend = legend({'Uniform', 'CRLB', 'Lambda'});
figureProperties_plot(structHandler)
axis([-30 30 -0 0.03])
