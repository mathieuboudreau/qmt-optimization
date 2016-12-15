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
    assert(isfield(matStruct,'SPGR_Tissue_params'), 'Loaded mat file did not contain a variable named SPGR_Tissue_params')
    assert(isa(matStruct.SPGR_Tissue_params,'containers.Map'), 'Loaded variable SPGR_Tissue_params is not of type ''containers.Map''')
    
    for ii = 1:length(SPGR_Tissue.paramsKeys)
        assert(isKey(matStruct.SPGR_Tissue_params, SPGR_Tissue.paramsKeys(ii)), ['Loaded dictionnary SPGR_Tissue_params is missing the following key: ' cell2mat(SPGR_Tissue.paramsKeys(ii))])
    end
    
    % Load values into object
    obj.params =  containers.Map(SPGR_Tissue.paramsKeys, values(matStruct.SPGR_Tissue_params,SPGR_Tissue.paramsKeys));

end
