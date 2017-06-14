close all, clear all, clc

load('/Users/mathieuboudreau/Work/Projects/qMTLab_Tab1s/src/cache/v0.3.mat');
A=jacobianObj.getJacobianStruct;
Amat=A.jacobianMatrix(:,[1 2 4 5]);
bVec_IR = A.jacobianMatrix(:,6);
bVec_VFA = A.jacobianMatrix(:,7);

IR = Amat\(-bVec_IR*[-0.3:0.01:0.3]);
VFA = Amat\(-bVec_VFA*[-0.3:0.01:0.3]);

figure(1), plot([-0.3:0.01:0.3], VFA(1,:)./0.122*100, 'LineWidth', 2), hold on, plot([-0.3:0.01:0.3], IR(1,:)./0.122*100, 'r', 'LineWidth', 2), axis([-0.3 0.301 -100 100])
figure(2), plot([-0.3:0.01:0.3], VFA(2,:)./3.97*100, 'LineWidth', 2), hold on, plot([-0.3:0.01:0.3], IR(2,:)./3.97*100, 'r', 'LineWidth', 2), axis([-0.3 0.301 -100 100])
figure(3), plot([-0.3:0.01:0.3], VFA(3,:)./(1.0960e-5)*100, 'LineWidth', 2), hold on, plot([-0.3:0.01:0.3], IR(3,:)./(1.0960e-5)*100, 'r', 'LineWidth', 2), axis([-0.301 0.3 -100 100])
figure(4), plot([-0.3:0.01:0.3], VFA(4,:)./0.0272*100, 'LineWidth', 2), hold on, plot([-0.3:0.01:0.3], IR(4,:)./0.0272*100, 'r', 'LineWidth', 2), axis([-0.3 0.301 -100 100])


legendLines = {'VFA', 'IR'};

structHandler.figure = figure(1);
structHandler.xlabel = xlabel('B1 (n.u.)');
structHandler.ylabel = ylabel('delta F');
structHandler.legend = legend(string(num2cell(legendLines)));

figureProperties_plot(structHandler)

structHandler.figure = figure(2);
structHandler.xlabel = xlabel('B1 (n.u.)');
structHandler.ylabel = ylabel('delta kf');
structHandler.legend = legend(string(num2cell(legendLines)));

figureProperties_plot(structHandler)

structHandler.figure = figure(3);
structHandler.xlabel = xlabel('B1 (n.u.)');
structHandler.ylabel = ylabel('delta T2r');
structHandler.legend = legend(string(num2cell(legendLines)));

figureProperties_plot(structHandler)

structHandler.figure = figure(4);
structHandler.xlabel = xlabel('B1 (n.u.)');
structHandler.ylabel = ylabel('delta T2f');
structHandler.legend = legend(string(num2cell(legendLines)));

figureProperties_plot(structHandler)



