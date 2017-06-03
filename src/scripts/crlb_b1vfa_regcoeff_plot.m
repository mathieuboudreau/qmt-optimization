clear all; close all; clc

load('/Users/mathieuboudreau/Work/Projects/qMT_B1_Optimization_Paper_Analysis/processing/stage_2/part_3/processed_jacobians/312point_protocol.mat')
opts = struct('fitParams', {{'F', 'kf', 'T2f', 'T2r'}});
opts.b1Params={'B1_IR', 'B1_VFA'};
A=IterativeOptimization(jacobianObj, opts);

lambda = [0, 0.01, 0.1, 0.5, 1, 2, 5];

for ii = 1:length(lambda)

    A.computeRegularized({'CRLB', 'B1_VFA'}, lambda(ii))
    [Xsorted, Ysorted] = A.getSorted();
    figure(1), hold on, plot(Xsorted(5:end), calcVarianceEfficiency(Xsorted(5:end), Ysorted(5:end)), 'LineWidth', 2), hold off
    [Xsorted, Ysorted] = A.getSortedRegTerm();
    figure(2), hold on, plot(Xsorted(5:end), Ysorted(5:end), 'LineWidth', 2), hold off
end

figure(2), hold on

structHandler.figure = figure(1);
structHandler.xlabel = xlabel('# acq. points');
structHandler.ylabel = ylabel('Variance Efficiency');
structHandler.legend = legend(string(num2cell(lambda)));

figureProperties_plot(structHandler)

structHandler.figure = figure(2);
structHandler.xlabel = xlabel('# acq. points');
structHandler.ylabel = ylabel('deltaF');
structHandler.legend = legend(string(num2cell(lambda)));

figureProperties_plot(structHandler)