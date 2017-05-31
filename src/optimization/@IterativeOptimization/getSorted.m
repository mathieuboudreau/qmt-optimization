function [rankedAcqPoints_sorted, metricValsAcqPoints_sorted] = getSorted(obj)
%GETSORTED Returns the sorted rankedAcqPoints and metricValsAcqPoints
%properties.

    [rankedAcqPoints_sorted, SortIndex] = sort(obj.rankedAcqPoints);
    metricValsAcqPoints_sorted =  obj.metricValsAcqPoints(SortIndex);

end

