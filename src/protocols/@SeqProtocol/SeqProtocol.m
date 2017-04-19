classdef (Abstract = true) SeqProtocol < handle
    %SEQPROTOCOL Abstract class for MRI pulse sequence protocols
    %
    %   Save and load methods deal strictly at importing/exporting the
    %   protocol property from/to external files.
    %
    %   getProtocol should give the objects protocol details/variables in a
    %   human redable format for the user.

    properties (Access = protected)
        protocol
    end

    methods (Access = public)
        % Save/Load object
        save(obj, fileName)
        load(obj, fileName)

        % Set/Get methods
        prot = getProtocol(obj)
            % **Abstract**
            totalNumOfMeas = getNumberOfMeas(obj);
            paramValue = getParameter(obj, protKey)
            remove(obj, indices);

    end

end

