function metricValues = calcMetricFor_N_Minus_1_Subsets(obj,jacobianSubset)

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
            otherwise
               error('IterativeOptimization:UnknownMetric', 'Unkown minimization metric.')
        end
    end
    
end
