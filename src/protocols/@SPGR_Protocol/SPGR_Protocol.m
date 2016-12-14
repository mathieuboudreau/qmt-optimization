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
        function [] = save(obj, fileName)
            prot = obj.protocol;
            prot.FileName = fileName;

            try
                save(fileName, '-mat', '-struct', 'prot');
            catch ME
                error(ME.identifier, ME.message)
            end

            clear prot
        end

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
