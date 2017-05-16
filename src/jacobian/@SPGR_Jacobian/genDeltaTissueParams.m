function deltaTissueParams = genDeltaTissueParams(obj, tissueJacStruct, tissueParams, computeOpts, paramIndex)
%GENDELTATISSUEPARAMS Generate the tissue parameters for the partial
%derivative calculation relative to the tissue indexed.

    switch obj.jacobianStruct.paramsKeys{paramIndex}
        case 'B1_IR'
            deltaTissueParams = tissueParams;
        otherwise
            derivSign = obj.derivMap(obj.derivMapDirection);
    
            deltaTissueParams = tissueParams;
            
            if strcmp(obj.jacobianStruct.paramsKeys{paramIndex}, 'B1_VFA')

                tissueIndex = find(~cellfun(@isempty, strfind(obj.tissueParamsObj.fitParamsKeys, 'R1f'))); % Parameter that will delta will be applied to.
                
                delta_R1f = calcDeltaR1f_VFA_DueToDeltaB1(obj, tissueParams, derivSign);
                
                % Get set of dParams for new dT1f
                deltaTissueParams(tissueIndex) = delta_R1f;

            else
                tissueIndex = find(~cellfun(@isempty, strfind(obj.tissueParamsObj.fitParamsKeys, computeOpts.paramsOfInterest{paramIndex})));

                deltaTissueParams(tissueIndex) = deltaTissueParams(tissueIndex) + derivSign * tissueJacStruct.differential(cell2mat(tissueJacStruct.keys(tissueIndex)));
            end
    end
end

function deltaR1f = calcDeltaR1f_VFA_DueToDeltaB1(obj, tissueParams, derivSign)
                pIndex.F = find(~cellfun(@isempty, strfind(obj.tissueParamsObj.fitParamsKeys, 'F')));
                pIndex.kf = find(~cellfun(@isempty, strfind(obj.tissueParamsObj.fitParamsKeys, 'kf')));
                pIndex.R1f = find(~cellfun(@isempty, strfind(obj.tissueParamsObj.fitParamsKeys, 'R1f')));

                % Setup conversion values
                F = tissueParams(pIndex.F);
                kf = tissueParams(pIndex.kf);
                T1f = 1./tissueParams(pIndex.R1f);
                T1r = 1;

                t1f2t1measParams = [F kf T1f T1r];

                %Get VFA T1meas val for dB1
                trueT1meas = convert_T1f_T1meas(t1f2t1measParams, 't1f_2_t1meas');

                % Fixed VFA parameters
                TR = 0.015; % s
                FAs = [3 20]; % deg
                deltaB1 = 1 + derivSign * (obj.deltaPerc/100);

                [dT1meas, ~, ~, ~] = estimateVFAT1Error(trueT1meas, TR, FAs, deltaB1);

                % Get T1f val for the dT1meas
                t1meas2t1fParams = t1f2t1measParams;
                t1meas2t1fParams(3) = dT1meas;
                dT1f = convert_T1f_T1meas(t1meas2t1fParams, 't1meas_2_t1f');

                deltaR1f = 1/dT1f;
end