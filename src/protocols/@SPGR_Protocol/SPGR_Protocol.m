classdef SPGR_Protocol < SeqProtocol & AbstractSPGR
    %SPGR_PROTOCOL SPGR qMT Protocol class
    %
    %   Parent class: SeqProtocol

    properties (Access = protected)
    end
    
    properties (Constant, Access = public)
        fitProtKeys = {'B1_IR', 'B1_VFA'};
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

        % Set/Get methods
        totalNumOfMeas = getNumberOfMeas(obj);
        paramValue = getParameter(obj, protKey)
        remove(obj, indices);
    end
end
