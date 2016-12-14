classdef SPGR_Protocol < SeqProtocol & AbstractSPGR
    %SPGR_PROTOCOL SPGR qMT Protocol class
    %
    %   Parent class: SeqProtocol

    properties (Access = protected)
        protocol;
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

        function [] = load(obj, fileName)
            try
                obj.protocol = load(fileName, '-mat');
            catch ME
                error(ME.identifier, ME.message)
            end
        end

        % Set/Get methods

        function prot = getProtocol(obj)
           prot = obj.protocol;
        end
    end
end
