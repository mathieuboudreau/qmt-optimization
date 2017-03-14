function computeOpts = compute(obj, computeOpts)
%COMPUTE Computes the Jacobian matrix for the objects acquisition protocol
% and tissue parameters.

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
