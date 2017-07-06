function [] = save(obj, fileName)
%SAVE Save fit options to mat file.

    fitOpts = obj.fitOpts;
    fitOpts.FileName = fileName;

    try
        save(fileName, '-mat', '-struct', 'fitOpts');
    catch ME
        error(ME.identifier, ME.message)
    end

    clear fitOpts
end