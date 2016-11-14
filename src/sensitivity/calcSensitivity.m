function [sensitivityOfInterest, zSpectrum, d_zSpectrum, Prot] = calcSensitivity(qMT5Params, paramOfInterest, protocolFile, varargin)
%CALCSENSITIVITY Calculate the sensitivity of the MT signal relative to a
%parameter of interest. Current implementation uses the 5 parameter qMT
%SPGR model by Sled & Pike and using a simulated signal calculation until
%the steady-state converges.
%
%   ****************************** args ***********************************
%   qMT5Params: [F,kf,R1f,T2f,T2r] % R1f is in seconds
%   paramOfInterest: Logical mask for qMT5Param. For example, to do the
%                    partial derivative relative to kf, the logical mask
%                    would be [0 1 0 0 0].
%   varargin
%           {1} -> deltaPerc: The percentage in variation of the
%                             parameterOfInterest to calculate the partial
%                             derivative.
%                             Default = 0.01 %.
%
%   ***************************** return **********************************
%   sensitivityOfInterest: Array of calculated sensitivity values for the
%                          Z-spectrum.
%   zSpectrum: Array of steady-state MT-SPGR signal values for the
%              Z-spectrum using the qMT5Params tissue parameter values.
%   d_zSpectrum: Array of steady-state MT-SPGR signal values for the
%              Z-spectrum using the qMT5Params tissue parameter values
%              ***plus*** deltaPerc/100 * the parameter-of-interest (POI)
%              for the POI.
%   Prot: Sructure containing the sequence protocol values.
%

    if length(varargin) == 1
        deltaPerc = varargin{1};
    else
        deltaPerc = 10^(-2);
    end
    
    if strcmp(paramOfInterest,'B1')
            trueB1 = 1;
 
            prot = load(protocolFile);
            prot.Alpha = prot.Alpha * (trueB1 + trueB1 * (deltaPerc/100));
            prot.Angles = prot.Angles * (trueB1 + trueB1 * (deltaPerc/100));

            save('tmp.mat', '-struct', 'prot');
            
            [zSpectrum,      ~]   = generateSignalSPGR(qMT5Params, protocolFile);
            [d_zSpectrum, Prot]   = generateSignalSPGR(qMT5Params, 'tmp.mat');
            sensitivityOfInterest = (d_zSpectrum - zSpectrum) ...
                                             /            ...
                                 ((trueB1)*(deltaPerc/100));
            delete('tmp.mat');

    elseif strcmp(paramOfInterest,'B1_VFA')
            % Vary B1 first
            trueB1 = 1;
 
            prot = load(protocolFile);
            prot.Alpha = prot.Alpha * (trueB1 + trueB1 * (deltaPerc/100));
            prot.Angles = prot.Angles * (trueB1 + trueB1 * (deltaPerc/100));
 
            save('tmp.mat', '-struct', 'prot');
            % Now vary T1f according to the change we would expect in
            % VFA T1meas           
            
            % Fixed VFA parameters
            TR = 0.015; % s
            FAs = [3 20]; % deg
            B1ErrorRange = trueB1 + trueB1 * (deltaPerc/100);
 
            % Setup conversion values
            T1r = 1;
            t1f2t1measParams = [qMT5Params(1) qMT5Params(2) 1/qMT5Params(3) T1r];

            %Get VFA T1 val for dB1
            trueT1meas = convert_T1f_T1meas(t1f2t1measParams, 't1f_2_t1meas');
            [dT1meas, ~, ~, ~] = estimateVFAT1Error(trueT1meas, TR, FAs, B1ErrorRange);

            % Get T1f val for the dT1meas
            t1meas2t1fParams = t1f2t1measParams;
            t1meas2t1fParams(3) = dT1meas;
            dT1f = convert_T1f_T1meas(t1meas2t1fParams, 't1meas_2_t1f');

            % Get set of dParams for new dT1f
            dqMT5Params = qMT5Params;
            dqMT5Params(3) = 1/dT1f; %Param 3 is supposed to be R1f, so invert.
            
            [zSpectrum,      ~]   = generateSignalSPGR(qMT5Params, protocolFile);
            [d_zSpectrum, Prot]   = generateSignalSPGR(dqMT5Params, 'tmp.mat');
            sensitivityOfInterest = (d_zSpectrum - zSpectrum) ...
                                             /            ...
                                 ((trueB1)*(deltaPerc/100));
            delete('tmp.mat');
    else
        d_qMT5Params = qMT5Params + (qMT5Params.*paramOfInterest)*(deltaPerc/100);

        [zSpectrum,      ~]   = generateSignalSPGR(qMT5Params, protocolFile);
        [d_zSpectrum, Prot]   = generateSignalSPGR(d_qMT5Params, protocolFile);

        sensitivityOfInterest = (d_zSpectrum - zSpectrum) ...
                                             /            ...
                ( qMT5Params(logical( paramOfInterest ))*(deltaPerc/100) );
    end

end

