function [jacobianSubset, acqPointRows] = getJacobianSubset(obj)
%GETJACOBIANSubset Get the Jacobian consisting of the unranked acquisition
%   points/rows.

    jacobianSubset = obj.fitParamJacobian(~obj.rankedAcqPoints);

    acqPointRows = find(~obj.rankedAcqPoints);
end
