classdef SPGR_Optimization < SeqOptimization
    %SPGR_OPTIMIZATION Optimize a set of SPGR qMT acquisitions.
    %
    %   --Initialization--
    %
    %   --Methods--
    %


    properties (Access = protected)
    end

    methods (Access = public)
        % Constructor
        function obj = SPGR_Optimization()
            obj = obj@SeqOptimization();
        end
    end
    
    methods (Access = protected)
    end

    methods (Static, Access = public)
    end

end

