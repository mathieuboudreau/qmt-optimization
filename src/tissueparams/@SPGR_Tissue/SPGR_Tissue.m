classdef SPGR_Tissue < TissueParams & AbstractSPGR
    %SPGR_TISSUE Class to handle the set of qMT SPGR tissue parameters.
    %
    %   --Properties--
    %   paramsKeys: Cell array representing the complete set of parameter
    %               key strings associated with tissue.
    %
    %   fitParamsKeys: Cell array of parameter keys strings required for
    %                  signal generation and/or fitting.
    %
    %   --Methods--
    %   save(fileName): Save tissue dictionary/map to a mat file.
    %
    %   load(fileName): Load tissue dictionary/map from *.mat file into
    %                   object. 
    %
    %   getParams(tissueKeys): Returns qMT tissue parameters array.
    %       *returns*: Array of doubles.
    %
    %   getParameter(paramKey): Returns qMT tissue parameters value for a
    %                           given key string.
    %       *returns*: Double single value.
    %

    properties (Access = protected)
    end

    properties (Constant, Access = public)
        paramsKeys = {'F', 'kf', 'R1f', 'R1r', 'T2f', 'T2r'};
        fitParamsKeys = {'F', 'kf', 'R1f', 'T2f', 'T2r'};
    end

    methods (Access = public)

        % Constructor
        function obj = SPGR_Tissue(paramsValues)
            % paramsValues: array with the values corresponding to
            %               paramsKeys.

            assert(isequal(size(paramsValues), size(SPGR_Tissue.paramsKeys)), 'Constructor argmuent must be an array of same size as the constant public property paramsKeys')

            obj.params = containers.Map(SPGR_Tissue.paramsKeys, paramsValues);
        end
    end

end
