classdef SPGR_Protocol < SeqProtocol & AbstractSPGR
    %SPGR_PROTOCOL SPGR qMT Protocol class.
    %
    %   --Properties--
    %   fitProtKeys: Keys representing additional/optional ancillary
    %                measurements.
    %
    %   B1_value: Default (assumed) value for B1 map. Fixed to a value of
    %            1.0 n.u.
    %
    %   --Methods--
    %   save(fileName): Save protocol to fileName.mat file.
    %
    %   load(fileName): Load protocol from fileName.mat file.
    %
    %   getProtocol(): Returns protocol.
    %       *returns*: Struct of protocol values.
    %
    %   getNumberOfMeas(): Returns the total number of measurements in a
    %                      protocol. 
    %       *returns*: Integer value.
    %
    %   getParameter(protKey): Returns qMT SPGR protocol parameters value
    %                          for given key.
    %       *returns*: (data type varies on key)
    %
    %   remove(indices): Remove sets of angle/offset acquisition points 
    %                    from the protocol. "indices" must be 1D and of 
    %                    same length as both protocol.Angles and
    %                    protocol.Offsets. Non-zero indicies remove 
    %                    protocol points.
    %

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
