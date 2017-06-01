function [rankedAcqPoints_sorted, reguTermValsAcqPoints_sorted] = getSortedRegTerm(obj)
%GETSORTED Returns the sorted rankedAcqPoints and metricValsAcqPoints
%properties.

    [rankedAcqPoints_sorted, SortIndex] = sort(obj.rankedAcqPoints);
    reguTermValsAcqPoints_sorted =  obj.reguTermValsAcqPoints(SortIndex);

    
    
end

