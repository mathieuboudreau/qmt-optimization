function paramValue = getParameter(obj, paramKey)
%GETPARAMETER Returns qMT SPGR tissue parameters value for given key.
%   paramKey (string) must be one of SPGRTissue.paramsKey values.

    % Type check & handle
    if iscell(paramKey)
       paramKey = cell2mat(paramKey);
    end

    % Check for key
    assert(isKey(obj.params, paramKey), 'Argument must be one of the one of SPGR_Tissue.paramsKeys strings')

    paramValue = obj.params(paramKey);
end
