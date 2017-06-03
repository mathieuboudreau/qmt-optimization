clear all; close all; clc

load('/Users/mathieuboudreau/Work/Projects/qMT_B1_Optimization_Paper_Analysis/processing/stage_2/part_3/processed_jacobians/312point_protocol.mat')
opts = struct('fitParams', {{'F', 'kf', 'T2f', 'T2r'}});
opts.b1Params={'B1_IR', 'B1_VFA'};
A=IterativeOptimization(jacobianObj, opts);

A.computeSingle('CRLB')

B=jacobianObj.getJacobianStruct();

figure()
for ii = 1:12
    semilogx(B.protocol(1:312/12,2), B.signal(1+(312/12)*(ii-1):((312/12)*(ii-1)+312/12)), 'Color', [0    0.4470    0.7410], 'LineWidth', 2), hold on
end


[~, optProtocol] = A.getSortedProtocol();
for ii=1:10
    point = ismember(B.protocol, optProtocol(ii,:), 'rows');
    semilogx(optProtocol(ii,2), B.signal(point), 'o', 'Color', [0.8500    0.3250    0.0980] , 'LineWidth', 2.5, 'MarkerSize', 10), hold on
end

A.computeRegularized({'CRLB', 'B1_VFA'}, 0.5)
B=jacobianObj.getJacobianStruct();

[~, optProtocol] = A.getSortedProtocol();
for ii=1:10
    point = ismember(B.protocol, optProtocol(ii,:), 'rows');
    semilogx(optProtocol(ii,2), B.signal(point), 'x', 'Color', [0.4940    0.1840    0.5560] , 'LineWidth', 2.5, 'MarkerSize', 10), hold on
end


structHandler.figure = figure(1);
structHandler.ylabel = xlabel('offset freq. (Hz)');
structHandler.xlabel = ylabel('Normalized MT Signal');
structHandler.legend = legend({'Search Space', 'CRLB', 'B_1-Regularized'});

figureProperties_plot(structHandler)
