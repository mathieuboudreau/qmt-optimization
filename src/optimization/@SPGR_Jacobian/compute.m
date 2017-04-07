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
if length(remainingRows) < computeOpts.lineBuffer
    rowsToDo = remainingRows;
else
    rowsToDo = remainingRows(1:computeOpts.lineBuffer);
end

%% Prepare/format variables required for fitting computation
%

% Get the full protocol that the object was initialized with
tissueJacStruct = obj.genTissueJacStruct();

%% Initialize parrallel pool
%

if ~ParPool.checkExistingSession()
    ParPool.instance();
end

%% Compute Jacobian rows
%
tmp_signal = nan(length(rowsToDo), 1);
d_tmp_signal = nan(length(rowsToDo), length(computeOpts.paramsOfInterest));

numParams = length(computeOpts.paramsOfInterest);

parfor rowIndex = 1:length(rowsToDo)
    % Setup protocol
    curProtPoint = obj.getProtocolPoint(rowsToDo(rowIndex));

    % Setup tissue params
    tmp_tissueParams = cell2mat(values(tissueJacStruct.value,tissueJacStruct.keys));

    % Simulate the signal without varying any of the parameters
    tmp_signal(rowIndex,1) = obj.simulateSignal(curProtPoint, tmp_tissueParams);

    for paramIndex = 1:numParams
        % If applicable, generate protocol point for the partial "derivative" relative to a "tissueIndex" (note: change name) that may be a measurement correction param (e.g. B1, B0). 
        d_curProtPoint = genDeltaProtPoint(obj, curProtPoint); % Currently not implemented to change prot point, template for future.

        % If applicable, generate tissue parameters for the partial "derivative" relative to the tissue of interest for this index. 
        d_tmp_tissueParams = genDeltaTissueParams(obj, tissueJacStruct, tmp_tissueParams, computeOpts, paramIndex);

        d_tmp_signal(rowIndex, paramIndex) = obj.simulateSignal(d_curProtPoint, d_tmp_tissueParams);
    end
end

%% Store Jacobian rows in object
%

if or(any(any(isnan(tmp_signal))), any(any(isnan(d_tmp_signal))))
    error('SeqJacobian:NaNValue', 'At least one of the calculate Jacobian values is NaN.')
else
    obj.jacobianStruct.signal(rowsToDo',1) = tmp_signal;
    obj.jacobianStruct.d_signal(rowsToDo',:) = d_tmp_signal;
    
    for paramIndex = 1:numParams % "x" - since it's not easy to comment the partial derivative or vector signs further down.
        % f(x)
        tmp_func_x = obj.jacobianStruct.signal(rowsToDo');

        % f(x+h) "forward", f(x-h) "backward"
        tmp_func_x_delta = obj.jacobianStruct.d_signal(rowsToDo', paramIndex);
        
        % h
        tmp_delta = tissueJacStruct.differential(cell2mat(obj.jacobianStruct.paramsKeys(paramIndex)));

        %df/dx, partial derivative
        obj.jacobianStruct.jacobianMatrix(rowsToDo', paramIndex) = obj.calcDerivative(tmp_func_x, tmp_func_x_delta, tmp_delta);
    end
    obj.jacobianStruct.completedLines(rowsToDo') = 1;
end

%% Update computeOpts
%

if any(isnan(obj.jacobianStruct.jacobianMatrix(:))) % Uncompleted lines have nan row elements
    computeOpts.mode = 'Resume';
else                                                % Completed lines have nan row elements
    computeOpts.mode = 'Completed';
    obj.jacobianStruct.status = 'Completed';
end

end


%% Method helper functions
%

function clean(obj)
    obj.jacobianStruct = struct('jacobianMatrix',[]);
end

function setup(obj, computeOpts)
    obj.jacobianStruct.jacobianMatrix = nan(obj.protocolObj.getNumberOfMeas, length(computeOpts.paramsOfInterest));  %Important to keep uncompleted lines nans, to properly update the mode at the end of a loop.
    
    obj.jacobianStruct.paramsKeys = computeOpts.paramsOfInterest;
    
    % Set tissue vals
    tissueJacStruct = obj.genTissueJacStruct();
    obj.jacobianStruct.paramsVals = cell2mat(values(tissueJacStruct.value, obj.jacobianStruct.paramsKeys));

    % Set pertinent protocol vals
    tmpProtocol = obj.protocolObj.getProtocol;
    obj.jacobianStruct.protocol(:,1) = tmpProtocol.Angles;
    obj.jacobianStruct.protocol(:,2) = tmpProtocol.Offsets;

    obj.jacobianStruct.status = 'Incomplete';
    obj.jacobianStruct.completedLines = zeros(obj.protocolObj.getNumberOfMeas, 1);
end
