classdef SPGR_FitOpts < SeqFitOpts & AbstractSPGR
    %SPGR_FitOpts SPGR qMT Fitting Options class.
    %
    %   --Properties--
    %   fitVars: Constant cell array. Lists the variables required to be in
    %            the loaded fitting file during object initialization.
    %
    %   --Methods--
    %   save(fileName): Save fitting options to fileName.mat file.
    %
    %   load(fileName): Load fitting options from fileName.mat file.
    %
    %   getFitOpts(): Returns fitting optiond.
    %       *returns*: Struct of fitting options values.
    %

    properties (Constant, Access = public)
        fitVars = {                  ...
                   'FileName',       ...   % Filename of fitting options file.
                   'FileType',       ...   % Reserved for qMRLab use.
                   'model',          ...   % Fitting model. Construct reqs. that it must be 'SledPikeRP'.
                   'lineshape',      ...   % Lineshape function of the restricted pool. 'SuperLorentzian' should be used for in vivo tissue data.
                   'names',          ...   % Cell array of strings. Names of the fitting parameters.
                   'fx',             ...   % Bool array. If array element is 1, fixes corresponding fitting parameter to its 'st' value.
                   'st',             ...   % Initial values of the fitting parameters.
                   'ub',             ...   % Upper bounds of the fitting parameter values.
                   'lb',             ...   % Lower bounds of the fitting parameter values.
                   'R1map',          ...   % Bool. Establishes if R1 (1/T1) map is used in the fitting.
                   'R1reqR1f',       ...   % Bool. Fixes R1r = R1f.
                   'FixR1fT2f',      ...   % (NOT CURRENTLY SUPPORTED) Bool. Fixes the value of the product of R1f*T2f in the Yarnykh model.
                   'FixR1fT2fValue', ...   % (NOT CURRENTLY SUPPORTED) Value of the product of R1f*T2f in the Yarnykh model.
                   };
    end
    
    properties (Access = protected)
    end

    methods (Access = public)
        % Constructor
        function obj = SPGR_FitOpts(fileName)
            obj = obj@SeqFitOpts(fileName);
            assert(strcmp(obj.fitOpts.model, 'SledPikeRP'), 'SPGR_FitOpts:Constructor', 'Incompatible fitting model for this class.')
            
            for fieldIndex=1:length(obj.fitVars)
                assert(isfield(obj.fitOpts, obj.fitVars{fieldIndex}), 'SPGR_FitOpts:Constructor', ['Missing variable in ', fileName, ': ', obj.fitVars{fieldIndex}])
            end

        end
    end

end
