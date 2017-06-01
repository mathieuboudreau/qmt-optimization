classdef IterativeOptimization < SeqOptimization
    %ITERATIVEOPTIMIZATION Optimize a set of qMT acquisitions iteratively.
    %
    %   --Initialization--
    %
    %   --Methods--
    %

    properties (Access = public)
       metricSet = {'CRLB'}; % Valid optimization metrics 
    end
    
    properties (Access = protected)
        minimMetric
        normalizationFlag = 'Normalized';

        regularizationTerm
        regularizationCoeff
        
        fitParams
        fitParamsValues
        fitParamJacobian
        
        b1Params
        b1ParamsJacobian
        
        rankedAcqPoints % Default is 0s
        metricValsAcqPoints % Default is nan;
        reguTermValsAcqPoints
    end

    methods (Access = public)
        % Constructor
        function obj = IterativeOptimization(SeqJacobian_Obj, opts)
            obj = obj@SeqOptimization(SeqJacobian_Obj, opts);
                        
            % Save initializer args
            obj.jacobianObj = SeqJacobian_Obj;
            obj.opts = opts;
            
            % Set opts
            obj.fitParams = obj.opts.fitParams;
            if isfield(opts,'b1Params')
                obj.b1Params = obj.opts.b1Params;
                obj.setB1ParamsJacobian();
                
                % Add B1Param names into the valid metric set to optimize for
                for ii = 1:length(obj.opts.b1Params)
                    obj.metricSet{end+1} = obj.opts.b1Params{ii};
                end
            end
            
            % Set properties
            obj.setFitParamJacobian();
            obj.setFitParamsValues();
            obj.resetRankedAcqPoints();
            obj.resetMetricValsAcqPoints();
        end

        % Compute methods
        computeSingle(obj, metricFlag)
        computeDoubleAlternate(obj, metricFlags)
        computeRegularized(obj, metricFlags, regularizationCoeff)
        
        % Get Methods
        rankedAcqPoints = getRankedAcqPoints(obj)
        metricValsAcqPoints  = getMetricValsAcqPoints(obj)
        reguTermValsAcqPoints  = getReguTermValsAcqPoints(obj)
        
        [rankedAcqPoints_sorted, metricValsAcqPoints_sorted] = getSorted(obj)
        [rankedAcqPoints_sorted, reguTermValsAcqPoints_sorted] = getSortedRegTerm(obj)
        [rankedAcqPoints_sorted, protocol_sorted] = getSortedProtocol(obj)
    end
    
    methods (Access = protected)
       setFitParamJacobian(obj)
       setB1ParamsJacobian(obj)
       resetRankedAcqPoints(obj)
       resetMetricValsAcqPoints(obj)
       resetReguTermValsAcqPoints(obj)
       
       [jacobianSubset, acqPointRows] = getJacobianSubset(obj)
       minValue = findMinDeltaMetricVal(obj, metricValues)
       minValue = findMinDeltaMetricVal_DoubleAlternate(obj, metricValues)
       [minMetriValue, minRegTermValue] = findMinDeltaMetricVal_Regularization(obj, minimMetricValues, regTermValues)
       
       metricValues = calcMetricFor_N_Minus_1_Subsets(obj, jacobianSubset, acqPointRows)
    end

    methods (Static, Access = public)
    end

end

