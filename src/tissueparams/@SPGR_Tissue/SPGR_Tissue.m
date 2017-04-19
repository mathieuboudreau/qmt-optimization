classdef SPGR_Tissue < TissueParams & AbstractSPGR
    %SPGR_TISSUE Class to handle for qMT SPGR tissue parameters.
    %
    %   Save and load methods deal strictly at importing/exporting the
    %   tissue parameter values from/to external files.
    %
    %   getParams should give the objects tissue parameters in a
    %   human redable format for the user.

    properties (Access = protected)
    end
    
    properties (Constant, Access = public)
        paramsKeys = {'F', 'kf', 'R1f', 'R1r', 'T2f', 'T2r'};
        fitParamsKeys = {'F', 'kf', 'R1f', 'T2f', 'T2r'};
    end
    
    methods (Access = public)
        
        % Constructor
        function obj = SPGR_Tissue(paramsValues)
            % paramsValues array with the values corresponding to 
            % paramsKeys
            
            assert(isequal(size(paramsValues), size(SPGR_Tissue.paramsKeys)), 'Constructor argmuent must be an array of same size as the constant public property paramsKeys')
            
            obj.params = containers.Map(SPGR_Tissue.paramsKeys, paramsValues);
        end
    end

end
