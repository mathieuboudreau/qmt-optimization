function paramsJacStruct = genParamsJacStruct(obj)
%GENPARAMSJACSTRUCT Generate parameter structure as a container for the
%tissue & parameter keys, respective values (map type), and respective differentials (map type).
    
    % Add tissue keys & vals
    paramsJacStruct.keys = obj.tissueParamsObj.fitParamsKeys;
    paramsJacStruct.value =  containers.Map(paramsJacStruct.keys, obj.tissueParamsObj.getParams(paramsJacStruct.keys));
    paramsJacStruct.differential =  containers.Map(paramsJacStruct.keys, obj.tissueParamsObj.getParams(paramsJacStruct.keys) .* (obj.deltaPerc/100));

    % Add protocol keys & vals
    for protKeysIndex = 1:length(obj.protocolObj.fitProtKeys)
        paramsJacStruct.keys{end+1} = obj.protocolObj.fitProtKeys{protKeysIndex};
        paramsJacStruct.value(obj.protocolObj.fitProtKeys{protKeysIndex}) = obj.protocolObj.getParameter(obj.protocolObj.fitProtKeys{protKeysIndex});
        paramsJacStruct.differential(obj.protocolObj.fitProtKeys{protKeysIndex}) = obj.protocolObj.getParameter(obj.protocolObj.fitProtKeys{protKeysIndex}) .* (obj.deltaPerc/100);
    end
end
