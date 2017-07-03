function paramValue = getParameter(obj, protKey)
%GETPARAMETER Returns qMT SPGR protocol parameters value for given key.
%   protKey (string) must be one of SPGR_Protocol.fitProtKeys values.

    % Type check & handle
    if iscell(protKey)
       protKey = cell2mat(protKey);
    end

    switch protKey
        case {'B1_IR', 'B1_VFA'}
            paramValue = obj.ancillaryMeasurements.idealVals('B1map');
        otherwise
            error('Key not found');
    end

end
