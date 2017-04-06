function deltaTissueParams = genDeltaTissueParams(obj, tissueJacStruct, tissueParams, computeOpts, paramIndex)
%GENDELTATISSUEPARAMS Generate the tissue parameters for the partial
%derivative calculation relative to the tissue indexed.

    tissueIndex = find(~cellfun(@isempty, strfind(obj.tissueParamsObj.fitParamsKeys, computeOpts.paramsOfInterest{paramIndex})));


    derivSign = obj.derivMap(obj.derivMapDirection);
    
    deltaTissueParams = tissueParams;
    deltaTissueParams(paramIndex) = deltaTissueParams(paramIndex) + derivSign * tissueJacStruct.differential(cell2mat(tissueJacStruct.keys(tissueIndex)));

end
