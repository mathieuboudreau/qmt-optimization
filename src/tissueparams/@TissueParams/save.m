function [] = save(obj, fileName)
%SAVE Save tissue dictionnary to a mat file.

    tissueParams = obj.params;

    assert(exist(fileName, 'file')==0, 'A file with that name already exists - cannot overwrite.')
    
    try
        save(fileName, '-mat', 'tissueParams');
    catch ME
        error(ME.identifier, ME.message)
    end

end
