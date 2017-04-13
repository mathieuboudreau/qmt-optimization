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
                F_Index = find(~cellfun(@isempty, strfind(obj.tissueParamsObj.fitParamsKeys, 'F')));
                kf_Index = find(~cellfun(@isempty, strfind(obj.tissueParamsObj.fitParamsKeys, 'kf')));
                R1f_Index = find(~cellfun(@isempty, strfind(obj.tissueParamsObj.fitParamsKeys, 'R1f')));
                
                tissueIndex = R1f_Index; % Parameter that will delta will be applied to.

                % Fixed VFA parameters
                TR = 0.015; % s
                FAs = [3 20]; % deg
                deltaB1 = 1 + derivSign * (obj.deltaPerc/100);

                % Setup conversion values
                F = tissueParams(F_Index);
                kf = tissueParams(kf_Index);
                T1r = 1;
                T1f = 1./tissueParams(R1f_Index);
                t1f2t1measParams = [F kf T1f T1r];
                
                %Get VFA T1 val for dB1
                trueT1meas = convert_T1f_T1meas(t1f2t1measParams, 't1f_2_t1meas');
                [dT1meas, ~, ~, ~] = estimateVFAT1Error(trueT1meas, TR, FAs, deltaB1);

                % Get T1f val for the dT1meas
                t1meas2t1fParams = t1f2t1measParams;
                t1meas2t1fParams(3) = dT1meas;
                dT1f = convert_T1f_T1meas(t1meas2t1fParams, 't1meas_2_t1f');

                % Get set of dParams for new dT1f
                deltaTissueParams(tissueIndex) = 1/dT1f;

            else
                tissueIndex = find(~cellfun(@isempty, strfind(obj.tissueParamsObj.fitParamsKeys, computeOpts.paramsOfInterest{paramIndex})));

                deltaTissueParams(tissueIndex) = deltaTissueParams(tissueIndex) + derivSign * tissueJacStruct.differential(cell2mat(tissueJacStruct.keys(tissueIndex)));
            end
    end
end
