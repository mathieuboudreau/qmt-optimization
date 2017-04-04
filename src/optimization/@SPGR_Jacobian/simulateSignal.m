function signalValues = simulateSignal(obj, curProtPoint, tissueParams)
%SIMULATESIGNAL Summary of this function goes here
%   Detailed explanation goes here

    tissueSim = generateSPGRSimParam('tmp.mat', tissueParams, 0);

    % Simulate the signal without varying any of the parameters
    [signalValues, ~] = SPGR_sim(tissueSim, curProtPoint);

end

