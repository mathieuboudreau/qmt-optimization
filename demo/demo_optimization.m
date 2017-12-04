%% DEMO_OPTIMIZATION
% Script demonstrating an example usage scenario for 
% regularized-optimization of qMT protocols using a cached Jacobian.
%
% On a 3.1 GHz Intel Core i5 processor, this scripts has a computation time
% of less than 1 minute.

clear all
close all
clc

%% Load cached Jacobian object
%

% See demo_jacobian_computation for example of how to calculate this cached
% Jacobian.
load('jacobians/312point_protocol.mat', 'jacobianObj');

%% Prepare optimization options
%

% Fitting parameters considered from the Jacobian columns
opts = struct('fitParams', {{'F', 'kf', 'T2f', 'T2r'}});

% Sensitivity parameters considered 
opts.b1Params={'B1_IR', 'B1_VFA'};

%% Compute regularized protocols
% Computes regularized protocols

% Initialize optimization object for the specified Jacobian.
optimizationObj=IterativeOptimization(jacobianObj, opts);

% Regularization coefficients
lambda = [0, 0.01, 0.1, 0.5, 1, 2, 5];

for ii = 1:length(lambda)
    
    % Initiate iterative protocol optimization using sensitivity
    % regularization. In its current state, this software only regularizes
    % for F-sensitivity, so 'B1_VFA' refers to the sensitivity of F to B1
    % inaccuracy if VFA T1 mapping is used.
    optimizationObj.computeRegularized({'CRLB', 'B1_VFA'}, lambda(ii))
    
    % Get the CRLB and F B1-sensitivies over the course of the iterative
    % optimization. iters are the iteration number, counting down from the
    % max protocol length (e.g. 312).
    [iterCRLBSorted{ii}, valCRLBSorted{ii}] = optimizationObj.getSorted();
    [iterRegTermSorted{ii}, RegTermSorted{ii}] = optimizationObj.getSortedRegTerm();
end


%% Plot Variance-Efficiency curves
%

for ii = 1:length(lambda)
    % Figures not plotted for values under 5 protocol parameters, as there
    % are only 4 free independent fitting parameters.
    figure(1), hold on, plot(iterCRLBSorted{ii}(5:end), calcVarianceEfficiency(iterCRLBSorted{ii}(5:end),valCRLBSorted{ii}(5:end)), 'LineWidth', 2), hold off
    figure(2), hold on, plot(iterRegTermSorted{ii}(5:end), RegTermSorted{ii}(5:end), 'LineWidth', 2), hold off
end

% Format figures
structHandler.figure = figure(1);
structHandler.xlabel = xlabel('# acq. points');
structHandler.ylabel = ylabel('Variance-Efficiency');
structHandler.legend = legend(string(num2cell(lambda)));
figureProperties_plot(structHandler)

structHandler.figure = figure(2);
structHandler.xlabel = xlabel('# acq. points');
structHandler.ylabel = ylabel('deltaF');
structHandler.legend = legend(string(num2cell(lambda)));
figureProperties_plot(structHandler)

%% Display 10-point optimized protocols
%

% Unregularized CRLB
optimizationObj.computeRegularized({'CRLB', 'B1_VFA'}, 0)
[rankedAcqPoints_sorted, protocol_sorted] = optimizationObj.getSortedProtocol();

disp('10-point protocol (FA and offsets) for the unregularized-CRLB optimization is: ')
protocol_sorted(rankedAcqPoints_sorted<=10,:)


% Regularized(0.5) CRLB
optimizationObj.computeRegularized({'CRLB', 'B1_VFA'}, 0.5)
[rankedAcqPoints_sorted, protocol_sorted] = optimizationObj.getSortedProtocol();

disp('10-point protocol (FA and offsets) for the unregularized-CRLB optimization is: ')
protocol_sorted(rankedAcqPoints_sorted<=10,:)