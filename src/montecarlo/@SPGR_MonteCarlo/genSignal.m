function noiselessSignal = genSignal(obj)
%GENSIGNAL Generate noiseless signal and store in object.
%

    %% Prepare tissue
    %
    fitParamsKeys = obj.tissueParamsObj.fitParamsKeys;
    tissueVals = obj.tissueParamsObj.getParams(fitParamsKeys);
    
    % Tissue structure required for signal generation
    tissueSim = generateSPGRSimParam('tmp.mat', tissueVals, 0); % 'tmp.mat' is a dummy value, req due to legacy qMTLab code

    %% Prepare protocol
    %

    protocol = obj.protocolObj.getProtocol();
    %% Simulate signal
    % Using steady-state driven SPGR
    
    [noiselessSignal, ~] = SPGR_sim(tissueSim, protocol);
    
    % Store signal in object
    obj.noiselessSignal = noiselessSignal;
end

