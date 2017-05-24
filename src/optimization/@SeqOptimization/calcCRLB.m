function crlb = calcCRLB(jacobianMatrix)
%CALCCRLB Calculate the Cramer-Rao Lower-Bound; the diagonal of the inverse
%of the Fisher Information matrix.
%   --args--
%   jacobianMatrix: A 2D matrix representing the Jacobian of the system.
%

    fisherInformationMatrix = SeqOptimization.calcFIM(jacobianMatrix);
    
    crlbMat = inv(fisherInformationMatrix);

    crlb = diag(crlbMat)';

end
