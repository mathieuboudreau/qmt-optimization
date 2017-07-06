function [prevVal, newVal] = setFitVar(obj, varName, varValue)
%SETFITVAR Set a fitting variable to a new value.
%   Detailed explanation goes here

    %% Type check
    %
    
    assert(isfield(obj.fitOpts, varName), 'SPGR_FitOpts:unknownFitVarName', [varName, ' is not a valid fitting variable name. See SPGR_FitOpts.fitVars for the valid list of fitting variables.'])
    assert(isa(varValue, class(obj.fitOpts.(varName))), 'SPGR_FitOpts:wrongVarValueType', ['The varValue parameter is not the same type as the current value in the object'' fitOpts. Call getFitOpts to see current values for all fitting variables.'])

    %% Save old value
    %
    
    prevVal = obj.fitOpts.(varName);
    
    %% Set value & save to output var
    %
    
    obj.fitOpts.(varName) = varValue;
    newVal = obj.fitOpts.(varName);

    
    %% Print details
    %

    fprintf('Previous %s value: ', varName), disp(prevVal)
    fprintf('New %s value:      ', varName), disp(newVal)

end
