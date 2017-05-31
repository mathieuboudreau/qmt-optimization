function [rankedAcqPoints_sorted, protocol_sorted] = getSortedProtocol(obj)
%GETSORTED Returns the sorted rankedAcqPoints and metricValsAcqPoints
%properties.
    jacobianStruct = obj.jacobianObj.getJacobianStruct();

    [rankedAcqPoints_sorted, SortIndex] = sort(obj.rankedAcqPoints);
    protocol_sorted =  jacobianStruct.protocol(SortIndex, :);

end

