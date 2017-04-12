classdef SPGR_Protocol < SeqProtocol & AbstractSPGR
    %SPGR_PROTOCOL SPGR qMT Protocol class
    %
    %   Parent class: SeqProtocol

    properties (Access = protected)
        protocol;
    end
    
    properties (Constant, Access = public)
        fitProtKeys = {'B1_IR'};
        B1_value = 1.0;
    end
    
    methods (Access = public)
        % Constructor
        function obj = SPGR_Protocol(fileName)
            try
                obj.load(fileName)
            catch ME
                error(ME.identifier, ME.message)
            end
        end

        % Prototypes
        remove(obj, indices);

        % Save/Load object
        save(obj, fileName)
        load(obj, fileName)

        % Set/Get methods
        prot = getProtocol(obj)
        totalNumOfMeas = getNumberOfMeas(obj);

        paramValue = getParameter(obj, protKey)
    end
end
