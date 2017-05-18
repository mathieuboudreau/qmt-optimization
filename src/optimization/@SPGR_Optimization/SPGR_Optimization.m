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
        function obj = SPGR_Optimization(SPGR_Jacobian_Obj, opts)
            obj = obj@SeqOptimization(SPGR_Jacobian_Obj, opts);
            
            assert(isa(SPGR_Jacobian_Obj, 'SPGR_Jacobian'))
            
            obj.jacobianObj = SPGR_Jacobian_Obj;
            obj.opts = opts;
        end
    end
    
    methods (Access = protected)
    end

    methods (Static, Access = public)
    end

end

