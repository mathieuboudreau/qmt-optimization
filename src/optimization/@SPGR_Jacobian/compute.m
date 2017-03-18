function computeOpts = compute(obj, computeOpts)
%COMPUTE Computes the Jacobian matrix for the objects acquisition protocol
% and tissue parameters.
%
%   computeOpts: Struct containing required jacobian computation options.
%       --Fields--
%       mode: String to flag the mode of the computation. Valid flags:
%             'Resume', 'New', and 'Completed'
%       paramsOfInterest: Cell array of strings. Each element must be one
%              of the TissueParams keys that the Jacobian object was
%              initialized with.
%       lineBuffer: Number of Jacobian rows to be calculated.

%% Pre-processing
%

switch computeOpts.mode
    case 'Resume'
        if isempty(obj.jacobianStruct.jacobianMatrix)
            clean(obj)
            setup(obj, computeOpts)            
        end
    case 'New'
        clean(obj)
        setup(obj, computeOpts)
    case 'Completed'
        warning('computeOpts.mode flag was set to Completed, obj.compute returned without further computation of Jacobian.')
        return
    otherwise
        error('SPGR_Jacobian:unknownComputeMode', 'computOpts.mode must be one of the following strings: Resume, New, or Completed')
end

%% Get array of row indices for this buffer calculation
%

remainingRows = getRemainingRows(obj);
if remainingRows < computeOpts.lineBuffer
    rowsToDo = remainingRows;
else
    rowsToDo = remainingRows(1:computeOpts.lineBuffer);
end

%% Prepare/format variables required for fitting computation
%

% Get the full protocol that the object was initialized with
fullProtocol = obj.protocolObj.getProtocol;
tissueJacStruct = obj.genTissueJacStruct();

%% Initialize parrallel pool
%

if ~ParPool.checkExistingSession()
    ParPool.instance();
end

%% Compute Jacobian rows
%

tmp = nan(length(rowsToDo), length(computeOpts.paramsOfInterest));
numParams = length(computeOpts.paramsOfInterest);

parfor rowIndex = 1:length(rowsToDo)
    tmp(rowIndex, :) = ones(1, numParams)
end

%% Store Jacobian rows in object
%

if any(any(isnan(tmp)))
    error('SeqJacobian:NaNValue', 'At least one of the calculate Jacobian values is NaN.')
else
    obj.jacobianStruct.jacobianMatrix(rowsToDo', :) = tmp;
end

%% Update computeOpts
%

if any(isnan(obj.jacobianStruct.jacobianMatrix(:))) % Uncompleted lines have nan row elements
    computeOpts.mode = 'Resume';
else                                                % Completed lines have nan row elements
    computeOpts.mode = 'Completed';
end

end


%% Method helper functions
%

function clean(obj)
    obj.jacobianStruct = struct('jacobianMatrix',[]);
end

function setup(obj, computeOpts)
    obj.jacobianStruct.jacobianMatrix = nan(obj.protocolObj.getNumberOfMeas, length(computeOpts.paramsOfInterest));  %Important to keep uncompleted lines nans, to properly update the mode at the end of a loop.

    obj.jacobianStruct.status = 'Incomplete';
    obj.jacobianStruct.completedLines = zeros(1, obj.protocolObj.getNumberOfMeas);
end