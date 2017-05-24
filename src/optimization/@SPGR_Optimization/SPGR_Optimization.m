classdef SPGR_Optimization < SeqOptimization
    %SPGR_OPTIMIZATION Optimize a set of SPGR qMT acquisitions.
    %
    %   --Initialization--
    %
    %   --Methods--
    %

    properties (Access = protected)
        minimMetric = 'CRLB';
        normalizationFlag = 'Normalized';
        
        fitParams
        fitParamsValues
        fitParamJacobian
        
        rankedAcqPoints % Default is 0s
        metricValsAcqPoints % Default is nan;
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
            obj.resetRankedAcqPoints();
            obj.resetMetricValsAcqPoints();
        end

        % Compute methods
        iterOptim(obj)
    end
    
    methods (Access = protected)
       setFitParamJacobian(jacobianObj, fitParams)
       resetRankedAcqPoints(obj)
       resetMetricValsAcqPoints(obj)
       
       
       [jacobianSubset, acqPointRows] = getJacobianSubset(obj)
       minValue = findMinDeltaMetricVal(obj, metricValues)
    end

    methods (Static, Access = public)
    end

end

