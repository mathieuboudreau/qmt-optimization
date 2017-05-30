function [] = computeSingle(obj, metricFlag)
%COMPUTESINGLE Summary of this function goes here
%   Detailed explanation goes here

    obj.resetRankedAcqPoints();
    obj.resetMetricValsAcqPoints();
    if(any(strcmp(obj.metricSet, metricFlag)))
        obj.minimMetric = metricFlag;
    else
        error('IterativeOptimization:UnknownMetric', 'Unkown minimization metric.')
    end

    while any(~obj.rankedAcqPoints)
        %% Get subset of Jacobian
        [jacobianSubset, acqPointRows] = obj.getJacobianSubset();
        
        %% Calculate the minimization metrics for each N-1 row subsets
        % metricValues will be same dims as acqPointRows
        metricValues = obj.calcMetricFor_N_Minus_1_Subsets(jacobianSubset);
        
        %% Find & store the metric value with minimum increase relative to last iteration
        %
        minValue = obj.findMinDeltaMetricVal(metricValues);
        
        acqPoint = acqPointRows( metricValues == minValue );

        %% Update rankedAcqPoints
        %
        obj.rankedAcqPoints(acqPoint) = sum(~obj.rankedAcqPoints);
        obj.metricValsAcqPoints(acqPoint) = minValue;
    end

end
