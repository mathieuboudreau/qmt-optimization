function paramsArray = getParams(obj)
%GETPARAMS Returns qMT SPGR tissue parameters array.

	paramsCell = values(obj.params, SPGR_Tissue.paramsKeys);
    
    paramsArray = cell2mat(paramsCell);
end
