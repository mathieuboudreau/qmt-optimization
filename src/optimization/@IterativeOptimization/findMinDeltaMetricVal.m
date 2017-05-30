function minValue = findMinDeltaMetricVal(obj, metricValues)
%FINDMINDELTAMETRICVAL Find the metric value which minimizes the increase
%from the previous iteration
%   metricValues: Array of metric values for all N-1 cases.
    
    nonZeroRankedPoints = obj.rankedAcqPoints(obj.rankedAcqPoints~=0);

    if isempty(nonZeroRankedPoints) % This will only be for the first iteration case.
        switch obj.minimMetric
            case 'CRLB'
                previousMetricVal = 1; % Because we are doing the ratio delta method.
            case {'B1_IR', 'B1_VFA'}
                % Nothing to do here
            otherwise
                error('Unkown minimization metric flag')
        end
    else
        previousPointIndex = find(obj.rankedAcqPoints == min(nonZeroRankedPoints));
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
