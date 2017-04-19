function [] = save(obj, fileName)
%SAVE Save tissue dictionnary to a mat file.

    SPGR_Tissue_params = obj.params;

    assert(exist(fileName, 'file')==0, 'A file with that name already exists - cannot overwrite.')
    
    try
        save(fileName, '-mat', 'SPGR_Tissue_params');
    catch ME
        error(ME.identifier, ME.message)
    end

end
