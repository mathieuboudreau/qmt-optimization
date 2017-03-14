function computeOpts = compute(obj, computeOpts)
%COMPUTE Computes the Jacobian matrix for the objects acquisition protocol
% and tissue parameters.
%
%   computeOpts: Struct containing required jacobian computation options.
%       --Fields--
%       mode: String to flag the mode of the computation. Valid flags:
%             'Resume', 'New', and 'Completed'

%% Pre-processing
% - If compuOpts.mode == 'Resume' flag, verify that jacobianStruct.jacobianMatrix is not empty. 
%   - If it is *not empty* resume computation immediately.
%   - If it is *empty*, call the obj.clean method to reset jacobianStruct.
%       - Set empty jacobianStruct.jacobianMatrix
%       - Set jacobianStruct.status to 'incomplete'
%       - Set jacobianStruct.completedLines to logical 1-D array of zeros.
%   - Call the obj.setup(compuOpts.paramsOfInterest)
%
% - If compuOpts.mode == 'New'
%   - Call the obj.clean method to reset jacobianStruct.
%   - Call the obj.setup(compuOpts.paramsOfInterest)
%
% - If compuOpts.mode == 'Completed', return immediately.


switch computeOpts.mode
    case 'Resume'
    case 'New'
    case 'Completed'
        warning('computeOpts.mode flag was set to Completed, obj.compute returned without further computation of Jacobian.')
        return
    otherwise
        error('SPGR_Jacobian:unknownComputeMode', 'computOpts.mode must be one of the following strings: Resume, New, or Completed')
end

%% Get array of row indices for this buffer calculation
%

%% Prepare/format variables required for fitting computation
%

%% Initialize parrallel pool
%

%% Compute Jacobian rows
%

%% Store Jacobian rows in object
%

end
