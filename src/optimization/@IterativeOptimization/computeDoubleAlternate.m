function [] = computeDoubleAlternate(obj, metricFlags)
%COMPUTEDOUBLEALTERNATE Summary of this function goes here
%   Detailed explanation goes here

    obj.resetRankedAcqPoints();
    obj.resetMetricValsAcqPoints();
    
    if(any(strcmp(obj.metricSet, metricFlags{1})) && any(strcmp(obj.metricSet, metricFlags{2})))
        metricIndex = 1;
        obj.minimMetric = metricFlags{metricIndex};
    else
        error('IterativeOptimization:UnknownMetric', 'Unkown minimization metric.')
    end
    
    while sum(~obj.rankedAcqPoints) >= length(obj.fitParams)
        %% Get subset of Jacobian
        [jacobianSubset, acqPointRows] = obj.getJacobianSubset();
        
        %% Calculate the minimization metrics for each N-1 row subsets
        % metricValues will be same dims as acqPointRows
        metricValues = obj.calcMetricFor_N_Minus_1_Subsets(jacobianSubset, acqPointRows);
        
        %% Find & store the metric value with minimum increase relative to last iteration
        %
        minValue = obj.findMinDeltaMetricVal_DoubleAlternate(metricValues);
        
        acqPoint = acqPointRows( metricValues == minValue );

        %% Update rankedAcqPoints
        %
        obj.rankedAcqPoints(acqPoint) = sum(~obj.rankedAcqPoints);
        obj.metricValsAcqPoints(acqPoint) = minValue;
        
        %% Switch metrics
        %
        switch metricIndex
            case 1
                metricIndex = 2;
            case 2
                metricIndex = 1;
        end
        obj.minimMetric = metricFlags{metricIndex};

    end

end
