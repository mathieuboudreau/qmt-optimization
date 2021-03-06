function paramsArray = getParams(obj, tissueKeys)
%GETPARAMS Returns qMT tissue parameters array.

    switch nargin
        case 2
            for ii=1:length(tissueKeys)
                paramsCell{ii} = obj.getParameter(tissueKeys(ii));
            end
        case 1
            paramsCell = values(obj.params, obj.paramsKeys);
        otherwise
            error('Non-static class methods must be called by an object');
    end
    
    paramsArray = cell2mat(paramsCell);
end
