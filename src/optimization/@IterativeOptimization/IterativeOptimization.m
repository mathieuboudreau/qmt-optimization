classdef IterativeOptimization < SeqOptimization
    %ITERATIVEOPTIMIZATION Optimize a set of qMT acquisitions iteratively.
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
        function obj = IterativeOptimization(SeqJacobian_Obj, opts)
            obj = obj@SeqOptimization(SeqJacobian_Obj, opts);
                        
            % Save initializer args
            obj.jacobianObj = SeqJacobian_Obj;
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
        
        % Get Methods
        rankedAcqPoints = getRankedAcqPoints(obj)
        metricValsAcqPoints  = getMetricValsAcqPoints(obj)
    end
    
    methods (Access = protected)
       setFitParamJacobian(jacobianObj, fitParams)
       resetRankedAcqPoints(obj)
       resetMetricValsAcqPoints(obj)
       
       
       [jacobianSubset, acqPointRows] = getJacobianSubset(obj)
       minValue = findMinDeltaMetricVal(obj, metricValues)
       metricValues = calcMetricFor_N_Minus_1_Subsets(obj,jacobianSubset)
    end

    methods (Static, Access = public)
    end

end

