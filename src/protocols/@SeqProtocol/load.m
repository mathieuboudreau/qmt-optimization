function [] = load(obj, fileName)
%LOAD Load protocol from mat file.

    try
        obj.protocol = load(fileName, '-mat');
    catch ME
        error(ME.identifier, ME.message)
    end
end