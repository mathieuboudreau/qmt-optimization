classdef SPGR_Optimization < SeqOptimization
    %SPGR_OPTIMIZATION Optimize a set of SPGR qMT acquisitions.
    %
    %   --Initialization--
    %
    %   --Methods--
    %


    properties (Access = protected)
        fitParams
        fitParamsValues
        fitParamJacobian
        
        measOptMask % Default is 0s
    end

    methods (Access = public)
        % Constructor
        function obj = SPGR_Optimization(SPGR_Jacobian_Obj, opts)
            obj = obj@SeqOptimization(SPGR_Jacobian_Obj, opts);
            
            assert(isa(SPGR_Jacobian_Obj, 'SPGR_Jacobian'))
            
            % Save initializer args
            obj.jacobianObj = SPGR_Jacobian_Obj;
            obj.opts = opts;
            
            % Set properties
            obj.fitParams = obj.opts.fitParams;
            obj.setFitParamJacobian();
            obj.setFitParamsValues();
            obj.measOptMask = zeros(size(fitParamJacobian,1), 1);
        end
    end
    
    methods (Access = protected)
       setFitParamJacobian(jacobianObj, fitParams)
    end

    methods (Static, Access = public)
    end

end

