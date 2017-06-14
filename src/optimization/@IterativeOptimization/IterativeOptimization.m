classdef IterativeOptimization < SeqOptimization
    %ITERATIVEOPTIMIZATION Optimize a set of qMT acquisitions iteratively.
    %
    %   --Initialization Args--
    %   1) SeqJacobian_Obj: SeqJacobian subclass object.
    %   2) opts: Optimization options struct
    %   	*opts properties*
    %       fitParams: (required)Cell array of strings of the fit 
    %                  parameters defined in the Jacobian object.
    %
    %       b1Params: (optional)Cell array of strings of the B1
    %                 parameters defined in the Jacobian object. These
    %                 strings are added to the metricSet property for
    %                 valid optimization metrics.
    %
    %   --Public Methods--
    %   computeSingle(metricFlag): Iteratively optimize protocol by
    %                              minimizing the metricFlag.
    %           (metricFlag: String. One defined in the metricSet public property)
    %
    %   computeDoubleAlternate(metricFlags): Iteratively optimize protocol alternating between 
    %                                        minimizing the methods set in by the strings in the 
    %                                        metricFlags.
    %           (metricFlags: 1x2 Cell array of strings. Defined in the
    %           metricSet public property.)
    %
    %   computeRegularized(metricFlags, regularizationCoeff): Iteratively optimize protocol by minimizing 
    %                                                         metricFlags{1}, regularized by metricFlags{2}. 
    %                                                         regularizationCoefficient is the multiplificative
    %                                                         factor of metricFlags{2}.
    %           (metricFlags: 1x2 Cell array of strings. Defined in the
    %           metricSet public property.
    %
    %           regularizationCoeff: int/float/double.)
    %       
    %   
    %   getRankedAcqPoints(): Returns thearry of protocol acquisition point
    %                         rankings from the iterative optimization.
    %
    %   getMetricValsAcqPoints(): Returns the array of values of metrics
    %                             for the protocol after that protocol point
    %                             was removed in the iterative optimization.
    %
    %   getReguTermValsAcqPoints(): Returns the array of values of the
    %                               regularization metric for the protocol 
    %                               after that protocol point was removed 
    %                               in the iterative optimization. Only 
    %                               valid if computeRetularized called to
    %                               optimized the protocol.
    %
    %   getSorted(): Returns [rankedAcqPoints_sorted,  metricValsAcqPoints_sorted], 
    %                which are sorted in descending order for the acqPoints.
    %
    %   getSortedRegTerm(): Returns [rankedAcqPoints_sorted, reguTermValsAcqPoints_sorted], 
    %                       which are sorted in descending order for the acqPoints.
    %
    %   getSortedProtocol(): Returns [rankedAcqPoints_sorted, protocol_sorted],
    %                        where protocol_sorted is the protocol property
    %                        of the jacobianStruc (property of SeqJacobian
    %                        objects).

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

