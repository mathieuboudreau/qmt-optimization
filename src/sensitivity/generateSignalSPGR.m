function [zSpectrum, Prot] = generateSignalSPGR(qMT5Params, varargin)
%GENERATESIGNALSPGR Generate noisless SPGR signal Z-spectrum for input qMT
%                   tissue parameters.
%
%   ****************************** args ***********************************
%   qMT5Params: [F,kf,R1f,T2f,T2r]
%   varargin
%           {1} -> noiseFlag: 0 (no noise) or 1 (default noise).
%           {2} -> filename: String containing filename for Prot to be
%                            saved as.
%
%   ***************************** return **********************************
%   zSpectrum: Array of steady-state MT-SPGR signal values for the
%              Z-spectrum using the qMT5Params tissue parameter values.
%   Prot: Sructure containing the sequence protocol values.
%

    if length(varargin) == 2
        filename  = varargin{2};
        noiseFlag = varargin{1};

    elseif length(varargin) == 1
        noiseFlag = varargin{1};

    else
        filename  = 'tmp';
        noiseFlag = 0; % Noiseless
    end

    [Sim.FileName, Sim.FileType, Sim.Opt, Sim.Param] = generateSPGRSimParam(filename,   ...
                                                                            qMT5Params, ...
                                                                            noiseFlag);
    Sim.Opt.SStol = 1e-5;
    Prot   = load('SPGR/Parameters/DemoProtocol.mat');   % load default protocol

    zSpectrum = SPGR_sim(Sim, Prot);
end
