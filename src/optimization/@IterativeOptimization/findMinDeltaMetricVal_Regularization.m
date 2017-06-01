function [minMetriValue, minRegTermValue] = findMinDeltaMetricVal_Regularization(obj, minimMetricValues, regTermValues)
%FINDMINDELTAMETRICVAL_REGULARIZATION Find the metric value which minimizes the increase
%from the previous iteration
%   metricValues: Array of metric values for all N-1 cases.
    
    nonZeroRankedPoints = obj.rankedAcqPoints(obj.rankedAcqPoints~=0);

    metricsFlags = {obj.minimMetric, obj.regularizationTerm};
 
    for metricsIndices = 1:length(metricsFlags)
        if isempty(nonZeroRankedPoints) % This will only be for the first iteration case.
            switch metricsFlags{metricsIndices}
                case 'CRLB'
                    previousMetricVal = 1; % Because we are doing the ratio delta method.
                case {'B1_IR', 'B1_VFA'}
                    % Nothing to do here
                otherwise
                    error('Unkown minimization metric flag')
            end
        else
            previousPointIndex = find(obj.rankedAcqPoints == min(nonZeroRankedPoints));

            if metricsIndices == 1
                previousMetricVal = obj.metricValsAcqPoints(previousPointIndex);
            else
                previousReguTermVal = obj.reguTermValsAcqPoints(previousPointIndex);
            end
        end

        if metricsIndices == 1
            metricValues = minimMetricValues;
        else
            metricValues = regTermValues;
        end
        
        switch metricsFlags{metricsIndices}
            case 'CRLB'
                % deltaVals . takes the ratio, and the smallest value will be the
                % lowest increase in stderr
                deltaVals{metricsIndices} = metricValues/previousMetricVal;
            case {'B1_IR', 'B1_VFA'}
                deltaVals{metricsIndices} = abs(metricValues);
            otherwise
                error('Unkown minimization metric flag')
        end

    end
    
    %%
    %
    
    deltaRegularized = deltaVals{1} + obj.regularizationCoeff * deltaVals{2};
    
    %%
    %
    
    minValIndex = find(deltaRegularized == min(deltaRegularized));

    minMetriValue = minimMetricValues(minValIndex);
    minRegTermValue = regTermValues(minValIndex);
end
