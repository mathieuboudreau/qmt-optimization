function [sensitivityOfInterest, zSpectrum, d_zSpectrum, Prot] = calcSensitivity(qMT5Params, paramOfInterest, varargin)
%CALCSENSITIVITY Calculate the sensitivity of the MT signal relative to a
%parameter of interest. Current implementation uses the 5 parameter qMT
%SPGR model by Sled & Pike and using a simulated signal calculation until
%the steady-state converges.
%
%   ****************************** args ***********************************
%   qMT5Params: [F,kf,R1f,T2f,T2r]
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

    d_qMT5Params = qMT5Params + (qMT5Params.*paramOfInterest)*(deltaPerc/100);

    [zSpectrum,      ~]   = generateSignalSPGR(qMT5Params);
    [d_zSpectrum, Prot]   = generateSignalSPGR(d_qMT5Params);

    sensitivityOfInterest = (d_zSpectrum - zSpectrum) ...
                                         /            ...
            ( qMT5Params(logical( paramOfInterest ))*(deltaPerc/100) );

end

