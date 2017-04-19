function [] = load(obj, fileName)
%LOAD Load mat file into object. 
%
% mat file must contain a variable called SPGR_Tissue_params that is of
% type 'containers.Map', and must have all the keys defined by 
% SPGR_Tissue.paramsKeys.

    % Load mat file
    try
        matStruct = load(fileName, '-mat');
    catch ME
        error(ME.identifier, ME.message)
    end

    % Verify loaded data before loading it into the object
    assert(isfield(matStruct,'tissueParams'), 'Loaded mat file did not contain a variable named tissuParams')
    assert(isa(matStruct.tissueParams,'containers.Map'), 'Loaded variable tissueParams is not of type ''containers.Map''')

    for ii = 1:length(obj.paramsKeys)
        assert(isKey(matStruct.tissueParams, obj.paramsKeys(ii)), ['Loaded dictionnary tissueParams is missing the following key: ' cell2mat(obj.paramsKeys(ii))])
    end

    % Load values into object
    obj.params =  containers.Map(obj.paramsKeys, values(matStruct.tissueParams, obj.paramsKeys));

end
