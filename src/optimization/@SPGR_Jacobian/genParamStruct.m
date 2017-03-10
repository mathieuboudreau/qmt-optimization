function paramStruct = genParamStruct(obj)
%GENPARAMSTRUCT Generate parameter structure as a container for the
%parameter keys, respective values (map type), and respective differentials (map type).
    
    paramStruct.keys = obj.tissueParamsObj.paramsKeys;
    
    paramStruct.values = containers.Map(paramStruct.keys, obj.tissueParamsObj.getParams());
    paramStruct.differentials = containers.Map(paramStruct.keys, obj.tissueParamsObj.getParams() .* (obj.deltaPerc/100) );

end
