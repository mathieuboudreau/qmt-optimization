function paramValue = getParameter(obj, paramKey)
%GETPARAMETER Returns qMT tissue parameters value for given key.
%   paramKey (string) must be one of obj.paramsKey values.

    % Type check & handle
    if iscell(paramKey)
       paramKey = cell2mat(paramKey);
    end

    % Check for key
    assert(isKey(obj.params, paramKey), 'Argument must be one of the one of obj.paramsKeys strings')

    paramValue = obj.params(paramKey);
end
