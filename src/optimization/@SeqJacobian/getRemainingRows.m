function remainingRows = getRemainingRows(obj)
%GETREMAININGROWS Get the remaining row indices in the Jacobian to be
%caluclated.

    remainingRows = find(all(isnan(obj.getJacobian),2));

end
