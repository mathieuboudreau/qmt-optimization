function data  = prep(obj, prepErrorStruct)
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
%
%   *Optional Arguments*
%
%   prepErrorStruct: Struct. Contains information required to simulate 
%                    errors in certain ancillary measures.
%
%       *fields*
%       name: String. Valid values: 'B1', 'T1', 'B1_IR', 'B1_VFA'
%       errorPerc: Number. The error % relative to the ideal values of the
%                  ancillary measure.
%
    %% Parse arguments
    %

    switch nargin
        case 2
            obj.prepErrorStruct = prepErrorStruct;
        case 1
            obj.prepErrorStruct = [];
        otherwise
            error('Method must be called from an object.')
    end
    
    %% Prep Noiseless Dataset
    %

    data.noiselessFittingData = prepDataset(obj, obj.noiselessSignal);
    
    %% Prep Noisy Dataset
    %
    data.noisyFittingData = prepDataset(obj, obj.noisyDataset);

    %% Store structs to class properties
    %
    
    obj.noiselessFittingData = data.noiselessFittingData;
    obj.noisyFittingData = data.noisyFittingData;

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
    if ~isempty(obj.prepErrorStruct)
        switch obj.prepErrorStruct.name
            case {'B1', 'B1_IR', 'B1_VFA'}
            	dataStruct.B1map = ones(voxelDim, 1, 1)*obj.protocolObj.ancillaryMeasurements.idealVals('B1map')*(1 + obj.prepErrorStruct.errorPerc/100);    
            otherwise
                dataStruct.B1map = ones(voxelDim, 1, 1)*obj.protocolObj.ancillaryMeasurements.idealVals('B1map');    
        end
    else    
    	dataStruct.B1map = ones(voxelDim, 1, 1)*obj.protocolObj.ancillaryMeasurements.idealVals('B1map');    
    end
    
    %% R1map

    obj.protocolObj.ancillaryMeasurements.idealVals('R1map') = getIdealR1Val(obj);
    
    if ~isempty(obj.prepErrorStruct)
        switch obj.prepErrorStruct.name
            case 'T1'
                errT1Val = (1/obj.protocolObj.ancillaryMeasurements.idealVals('R1map'))*(1+obj.prepErrorStruct.errorPerc/100);
            	dataStruct.R1map = ones(voxelDim, 1, 1)*(1/errT1Val);
            case 'B1_VFA'
                TR = 0.025; % s
                FAs = [3 20]; % deg
                trueT1 = 1/obj.protocolObj.ancillaryMeasurements.idealVals('R1map');
                B1val = obj.protocolObj.ancillaryMeasurements.idealVals('B1map')*(1 + obj.prepErrorStruct.errorPerc/100);

                [errT1Val , ~, ~, ~] = estimateVFAT1Error(trueT1, TR, FAs, B1val);
                
            	dataStruct.R1map = ones(voxelDim, 1, 1)*(1/errT1Val);
            otherwise
            	dataStruct.R1map = ones(voxelDim, 1, 1)*obj.protocolObj.ancillaryMeasurements.idealVals('R1map');
        end
    else
    	dataStruct.R1map = ones(voxelDim, 1, 1)*obj.protocolObj.ancillaryMeasurements.idealVals('R1map');
    end

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

