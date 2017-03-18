function tissueJacStruct = genTissueJacStruct(obj)
%GENTISSUEJACSTRUCT Generate TISSUEparameter structure as a container for the
%parameter keys, respective values (map type), and respective differentials (map type).
    
    tissueJacStruct.keys = obj.tissueParamsObj.fitParamsKeys;
    tissueJacStruct.value =  containers.Map(tissueJacStruct.keys, obj.tissueParamsObj.getParams(tissueJacStruct.keys));
    tissueJacStruct.differential =  containers.Map(tissueJacStruct.keys, obj.tissueParamsObj.getParams(tissueJacStruct.keys) .* (obj.deltaPerc/100));

end
