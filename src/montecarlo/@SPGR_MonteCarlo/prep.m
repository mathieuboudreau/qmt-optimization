function data  = prep(obj)
%PREP Prepare/reorganize the data into the format needed for fitting.
%   In qMRLab, SPGR qMT data requires a "data" structure with the fields 
%   MTdata, B0map, B1map, R1map, and Mask.
%
%   The fourth dimension of MTdata is the MT dimension (the first three are
%   the volume). MTdata must also be pre-normalized with the no-MT measure
%   (such that MTdata is between [0, 1] (in noiseless conditions; with
%   noise it can go above 1).
%
%   The data structure 'data' is saved as an object property, and is also
%   returned by the method call.

    %% Prep Noiseless Dataset
    %

    data.noiselessDataStruct = prepDataset(obj, obj.noiselessSignal);
    
    %% Prep Noisy Dataset
    %
    data.noisyDataStruct = prepDataset(obj, obj.noisyDataset);

    %% Store structs to class properties
    %
    
    obj.noiselessFittingData = data.noiselessDataStruct;
    obj.noisyFittingData = data.noisyDataStruct;

end

function dataStruct = prepDataset(obj, mtDataSet)
    %% Prep MTdata
    %
    
    mtDim = size(mtDataSet,1);
    voxelDim = size(mtDataSet,2);

    dataStruct.MTdata = zeros(voxelDim, 1, 1, mtDim);

    for mtIndex = 1:mtDim
        for voxelIndex = 1:voxelDim
            dataStruct.MTdata(voxelIndex, 1, 1, mtIndex) = mtDataSet(mtIndex,voxelIndex);
        end
    end
    
    %% B0map

    dataStruct.B0map = ones(voxelDim, 1, 1)*obj.protocolObj.ancillaryMeasurements.idealVals('B0map');    

    %% B1map

    dataStruct.B1map = ones(voxelDim, 1, 1)*obj.protocolObj.ancillaryMeasurements.idealVals('B1map');    

    %% R1map

    %Get VFA T1meas val for dB1
    obj.protocolObj.ancillaryMeasurements.idealVals('R1map') = getIdealR1Val(obj);
    
    dataStruct.R1map = ones(voxelDim, 1, 1)*obj.protocolObj.ancillaryMeasurements.idealVals('R1map');

    %% Mask
    dataStruct.Mask = ones(voxelDim, 1, 1);
    
end

function idealR1 = getIdealR1Val(obj)
    % Setup conversion values
    F = obj.tissueParamsObj.getParameter('F');
    kf = obj.tissueParamsObj.getParameter('kf');
    T1f = 1./obj.tissueParamsObj.getParameter('R1f');
    T1r = 1./obj.tissueParamsObj.getParameter('R1r');
    
    t1f2t1measParams = [F kf T1f T1r];
     
    idealR1 = 1/convert_T1f_T1meas(t1f2t1measParams, 't1f_2_t1meas');
end

