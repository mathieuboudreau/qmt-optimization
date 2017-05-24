function fisherInformationMatrix = calcFIM(jacobianMatrix)
%CALCFIM Calculate the Fisher Information Matrix
%   --args--
%   jacobianMatrix: A 2D matrix representing the Jacobian of the system.
%
%   See Eq. 5 in Cercignani, M. and Alexander, D. C. (2006), Optimal 
%   acquisition schemes for in vivo quantitative magnetization transfer 
%   MRI. Magn. Reson. Med., 56: 803?810. doi:10.1002/mrm.21003

    % Pre-allocate matrix
    fisherInformationMatrix = zeros(size(jacobianMatrix,2));
    SD = ones(1,size(jacobianMatrix,2)); % Standard deviation arbitrarily set to 1 for all,
                                         % params, as it is not a known parameter for us. May
                                         % extend the method to include it in the future

    for ii = 1:size(jacobianMatrix,2)
        for jj = 1: size(jacobianMatrix,2)

            % Calculate element-wise multiplications
            elemWiseMult = jacobianMatrix(:,ii).*jacobianMatrix(:,jj);

            fisherInformationMatrix(ii,jj) = 1/(SD(ii).*SD(jj)).*sum(elemWiseMult);
        end
    end

end
