function [] = computeRegularized(obj, metricFlags, regularizationCoeff)
%COMPUTEREGULARIZED Summary of this function goes here
%   Detailed explanation goes here

    obj.resetRankedAcqPoints();
    obj.resetMetricValsAcqPoints();
    obj.resetReguTermValsAcqPoints();

    if(any(strcmp(obj.metricSet, metricFlags{1})) && any(strcmp(obj.metricSet, metricFlags{2})))
        obj.minimMetric = metricFlags{1};
        obj.regularizationTerm = metricFlags{2};
        obj.regularizationCoeff = regularizationCoeff;
    else
        error('IterativeOptimization:UnknownMetric', 'Unkown minimization metric.')
    end

    while sum(~obj.rankedAcqPoints) > length(obj.fitParams)
        %% Get subset of Jacobian
        [jacobianSubset, acqPointRows] = obj.getJacobianSubset();
        
        %% Calculate the minimization metrics for each N-1 row subsets
        % minimMetricValues will be same dims as acqPointRows
        minimMetricValues = obj.calcMetricFor_N_Minus_1_Subsets(jacobianSubset, acqPointRows);
        
        %% Calculate the regularization metrics for each N-1 row subsets
        % regTermValues will be same dims as acqPointRows
        
        tmp_minimMetric = obj.minimMetric; % Store minimMetric into a tmp parameter.
        
        try
            obj.minimMetric = obj.regularizationTerm; % calcMetricFor_N_Minus_1_Subsets uses obj.minimMetric to evaluate calculations, so store regTerm into minmMetric.

        	regTermValues = obj.calcMetricFor_N_Minus_1_Subsets(jacobianSubset, acqPointRows);
            
            obj.minimMetric = tmp_minimMetric; % Reset minimMetric value to its true (stored) value

        catch ME
            obj.minimMetric = tmp_minimMetric; % Reset minimMetric value to its true (stored) value
            rethrow(ME);
        end
        
        %% Find & store the metric value with minimum increase relative to last iteration
        %
        [minMetriValue, minRegTermValue] = obj.findMinDeltaMetricVal_Regularization(minimMetricValues, regTermValues);
        
        acqPoint = acqPointRows( minimMetricValues == minMetriValue );

        %% Update rankedAcqPoints
        %
        obj.rankedAcqPoints(acqPoint) = sum(~obj.rankedAcqPoints);
        obj.metricValsAcqPoints(acqPoint) = minMetriValue;
        obj.reguTermValsAcqPoints(acqPoint) = minRegTermValue;
    end

end
