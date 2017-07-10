function fitResults = fit(obj)
%FIT Fit Monte Carlo data
%   Detailed explanation goes here

    %% Prepare protocol and fitting options
    %
    protocolStruct = obj.protocolObj.getProtocol();
    fitOptStruct = obj.fitOptsObj.getFitOpts();
    
    %% Noisless data
    dataStruct = obj.noiselessFittingData;

    fitResults.noiselessDataset = FitData(dataStruct, protocolStruct, fitOptStruct, 'SPGR', 0);
    
    %% Noisy data
    dataStruct = obj.noisyFittingData;
    fitResults.noisyDataset = FitData(dataStruct, protocolStruct, fitOptStruct, 'SPGR', 0);

    obj.fitResults = fitResults;
end
