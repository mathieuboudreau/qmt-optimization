classdef SPGR_Protocol < SeqProtocol & AbstractSPGR
    %SPGR_PROTOCOL SPGR qMT Protocol class.
    %
    %   --Properties--
    %   ancillaryMeasurements: Struct containing ancillary measurement
    %                          details.
    %           --fields--               
    %           names: Names of ancillary measurements.
    %           idealVals: containers.Map data type. Keys are the strings
    %                      in the 'names' field. Values are the 
    %                      default/ideal values.
    %
    %   fitProtKeys: Keys representing additional/optional ancillary
    %                measurements with SeqJacobian compatibility.
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
    
    properties (Access = public)
        ancillaryMeasurements = struct('names'        , {{'B0map', 'B1map', 'R1map'}}, ...
                                       'idealVals', containers.Map({'B0map', 'B1map', 'R1map'}, ...
                                                                   {    0.0,     1.0,     NaN})); % Default values.
                                                                 % {     Hz,    n.u.,       s}
    end
    
    properties (Constant, Access = public)
        fitProtKeys = {'B1_IR', 'B1_VFA'};
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
