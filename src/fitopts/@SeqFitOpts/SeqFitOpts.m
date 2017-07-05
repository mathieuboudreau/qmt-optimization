classdef (Abstract = true) SeqFitOpts < handle
    %SEQFITOPTS Abstract class for MRI pulse sequence data fitting options.
    %
    %   Save and load methods deal strictly at importing/exporting the
    %   fitting optoins property from/to external files.
    %
    %   getFitOpts should give the objects fitting options 
    %   details/variables in a human redable format for the user.
    %

    properties (Access = protected)
        fitOpts
    end

    methods (Access = public)
        % Constructor
        function obj = SeqFitOpts(fileName)
            try
                obj.load(fileName)
            catch ME
                error(ME.identifier, ME.message)
            end
        end

        % Save/Load object
        save(obj, fileName)
        load(obj, fileName)

        % Set/Get methods
        prot = getFitOpts(obj)
    end

end
