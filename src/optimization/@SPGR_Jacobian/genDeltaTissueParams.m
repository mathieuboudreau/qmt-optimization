function deltaTissueParams = genDeltaTissueParams(obj, tissueJacStruct, tissueParams, tissueIndex)
%GENDELTATISSUEPARAMS Generate the tissue parameters for the partial
%derivative calculation relative to the tissue indexed.

    derivSign = obj.derivMap(obj.derivMapDirection);
    
    deltaTissueParams = tissueParams;
    deltaTissueParams(tissueIndex) = deltaTissueParams(tissueIndex) + derivSign * tissueJacStruct.differential(cell2mat(tissueJacStruct.keys(tissueIndex)));

end
