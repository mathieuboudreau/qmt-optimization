function paramError = minimizeParamErrorBecauseOfMeasError(paramJacMat, measJacMat, measError)
%UNTITLED3 Solves equation of the type Ax=-b, where:
%   A=paramJacMat
%   x = paramError
%   b= measJacMat.*measError
%   
%   *jacMat variables are required to be Jacobians.
%
%   measJac is expected to be a 1D column vector, and measError is relative 
%   error in a fraction (e.g. 5% error in B1 = 1 would be 0.05).
%
%   paramError is the non-normalized relative error of each param. To get
%   the error in % for each parameter, paramError should be element-wise
%   divided by the value of each parameter, then multiplied by 100.

    paramError = paramJacMat\(-measJacMat.*measError);
end
