%% DEMO_JACOBIAN_COMPUTATION
% Script demonstrating an example usage scenario for creating and caching a
% qMT protocol Jacobian.
%
% On a 3.1 GHz Intel Core i5 processor, this scripts has a computation time
% of approximately 2h30m.

clear all
close all
clc

%% Prepare protocol and tissue objects for Jacobian calculation
%

% Tissue object creation
T1f = 0.9; %tmp
%               F    kf  R1f    R1r T2f   T2r
tissueParams = [0.15 4.0 1./T1f 1   0.030 12.0e-06];
clear T1f

tissueObj  = SPGR_Tissue(tissueParams);

% Protocol object creation
protocolLocation = 'protocols/312pt_12_FAs_26_offsets.mat'; % SPGR qMT protocol saved through the qMRLab GUI (qMRILab.m opens GUI)
protocolObj = SPGR_Protocol(protocolLocation);

%% Prepare Jacobian object and computation options
%

% Initial creation of Jacobian object, no computation yet
jacobianObj = SPGR_Jacobian(protocolObj, tissueObj);

% Jacobian computation options
computeOpts.mode = 'New'; % Start Jacobian computation from scratch - computes entire Jacobian matrix
computeOpts.paramsOfInterest = {'F', 'kf', 'R1f', 'T2r', 'T2f', 'B1_IR', 'B1_VFA'}; % Columns of Jacobian
computeOpts.lineBuffer = 26; % Number of jacobian lines computer per jacobian.compute call

%% Compute Jacobian
%

parpool % Startup  parrallel processing workers, if available
iterVal = 1;

disp('Begining Jacobian computation')
while ~strcmp(computeOpts.mode, 'Completed')
    computeOpts = jacobianObj.compute(computeOpts);
    
    save('jacobians/demo_312point_protocol.mat') % Save computed Jacobian lines at lineBuffer intervals, allows for resume.
    
    disp(['Computed Jacobian up to row ' num2str(iterVal*computeOpts.lineBuffer) ' out of of 312 rows.'])
    iterVal = iterVal + 1;
end

%% Saved expected jacobian
% If you want to simply plot Jacobian that is expected to be generated from
% the command above without processing the lengthy calculation, simply
% uncomment the line below (and comment the lines above), and run along 
% with the section that follows.

% load('jacobians/312point_protocol.mat', 'jacobianObj');

%% Plot Jacobian
%

plotOpts.lineStyle = '-o';
plotOpts.colorMode = 'rainbow';
plotOpts.dataMode = 'abs';
plotJacobianColumns(jacobianObj, plotOpts)
