function metricValues = calcMetricFor_N_Minus_1_Subsets(obj, jacobianSubset, acqPointRows)

   numPoints = size(jacobianSubset, 1);
    
    for ii = 1:numPoints
        % N-1 number of rows jacobian
        nm1Jacobian = jacobianSubset;
        nm1Jacobian(ii,:) = []; % Remove a row
        
        switch obj.minimMetric
            case 'CRLB'
                crlb = obj.calcCRLB(nm1Jacobian);
                if strcmp(obj.normalizationFlag, 'Normalized')
                    crlb = crlb./(obj.fitParamsValues.^2);
                end

                metricValues(ii,1) = sum(crlb); %With 'Normalized', Cercignani metric.
            case {'B1_IR', 'B1_VFA'}
                nm1B1JacMat = obj.b1ParamsJacobian(:, strcmp(obj.b1Params, obj.minimMetric));
                nm1B1JacMat = nm1B1JacMat(acqPointRows);
                nm1B1JacMat(ii,:) = []; % Remove a row
                
                B1error = 0.05;
                
                paramErrors = SeqOptimization.minimizeParamErrorBecauseOfMeasError(nm1Jacobian, nm1B1JacMat, B1error)'./obj.fitParamsValues.*100;
                metricValues(ii,1) = paramErrors(1); % Regularization is only set for F currently.
            otherwise
               error('IterativeOptimization:UnknownMetric', 'Unkown minimization metric.')
        end
    end
    
end
