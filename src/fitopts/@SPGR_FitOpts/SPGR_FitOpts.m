classdef SPGR_FitOpts < SeqFitOpts & AbstractSPGR
    %SPGR_FitOpts SPGR qMT Fitting Options class.
    %
    %   --Methods--
    %   save(fileName): Save fitting options to fileName.mat file.
    %
    %   load(fileName): Load fitting options from fileName.mat file.
    %
    %   getFitOpts(): Returns fitting optiond.
    %       *returns*: Struct of fitting options values.
    %

    properties (Access = protected)
    end

    methods (Access = public)
        % Constructor
        function obj = SPGR_FitOpts(fileName)
            obj = obj@SeqFitOpts(fileName);
            assert(strcmp(obj.fitOpts.model, 'SledPikeRP'), 'SPGR_FitOpts:Constructor', 'Incompatible fitting model for this class.')
        end
    end

end
