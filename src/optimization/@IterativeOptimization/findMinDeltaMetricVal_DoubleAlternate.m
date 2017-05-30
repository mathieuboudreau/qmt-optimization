function minValue = findMinDeltaMetricVal_DoubleAlternate(obj, metricValues)
%FINDMINDELTAMETRICVAL Find the metric value which minimizes the increase
%from the previous iteration
%   metricValues: Array of metric values for all N-1 cases.
    
    nonZeroRankedPoints = obj.rankedAcqPoints(obj.rankedAcqPoints~=0);

    if length(nonZeroRankedPoints) <=1 % This will only be for the first or second iteration case. (DoubleAlternate)
        switch obj.minimMetric
            case 'CRLB'
                previousMetricVal = 1; % Because we are doing the ratio delta method.
            case {'B1_IR', 'B1_VFA'}
                % Nothing to do here
            otherwise
                error('Unkown minimization metric flag')
        end
    else
        previousPointIndex = find(obj.rankedAcqPoints == min(nonZeroRankedPoints)+1); %+1 is to get the before last point in DoubleAlternate
        previousMetricVal = obj.metricValsAcqPoints(previousPointIndex);
    end

    switch obj.minimMetric
        case 'CRLB'
            % deltaVals . takes the ratio, and the smallest value will be the
            % lowest increase in stderr
            deltaVals = metricValues/previousMetricVal;
        case {'B1_IR', 'B1_VFA'}
            deltaVals = abs(metricValues);
        otherwise
            error('Unkown minimization metric flag')
    end

    minValIndex = find(deltaVals == min(deltaVals));
    minValue = metricValues(minValIndex);
end
