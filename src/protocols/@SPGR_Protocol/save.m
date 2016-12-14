function [] = save(obj, fileName)
%SAVE Save protocol to mat file.

    prot = obj.protocol;
    prot.FileName = fileName;

    try
        save(fileName, '-mat', '-struct', 'prot');
    catch ME
        error(ME.identifier, ME.message)
    end

    clear prot
end