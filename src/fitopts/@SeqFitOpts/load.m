function [] = load(obj, fileName)
%LOAD Load fit options from mat file.

    try
        obj.fitOpts = load(fileName, '-mat');
    catch ME
        error(ME.identifier, ME.message)
    end
end