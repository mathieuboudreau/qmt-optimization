function Sim = generateSPGRSimParam(filename, qMT5Params, noiseFlag)
%generateSPGRSimParam Generates parameters required to save a SimParam file
%                     in the formate matching qMTLab's.
%
%   qMT5Params: [F,kf,R1f,T2f,T2r]
%   filename  : string for output filename. Do not include .mat extention
%   noiseFlag : 0 - no noise, 1 - default noise

    Sim.FileName         = [filename,'.mat'];
    Sim.FileType         = 'SimParam';

    if noiseFlag
            Sim.Opt      = genNoiseOpt();
    elseif ~noiseFlag
            Sim.Opt      = genNoiselessOpt();
    end

    Sim.Param            = genParam(qMT5Params);

end

function [Param] = genParam(qMT5Params)
    % qMT5Params    = [F,kf,R1f,T2f,T2r]

    Param.F         = qMT5Params(1);
    Param.kf        = qMT5Params(2);
    Param.kr        = (Param.kf)/(Param.F);
    Param.R1f       = qMT5Params(3);
    Param.R1r       = 1;
    Param.T2f       = qMT5Params(4);
    Param.T2r       = qMT5Params(5);
    Param.M0f       = 1;
    Param.T1f       = 1/(Param.R1f);
    Param.T1r       = 1/(Param.R1r);
    Param.R2f       = 1/(Param.T2f);
    Param.R2r       = 1/(Param.T2r);
    Param.M0r       = Param.F;
    Param.lineshape = 'SuperLorentzian';
end

function [Opt] = genNoiselessOpt()
    Opt.AddNoise = 0;       % 0 or 1
    Opt.SNR      = 0;       % SNR level
    Opt.SScheck  = 1;       % 0 or 1, check steady state
    Opt.SStol    = 1.0e-05; % Steady state tolerance
    Opt.Reset    = 0;       % Reset M to equalibrium?
end


function [Opt] = genNoiseOpt()
    Opt.AddNoise = 1;       % 0 or 1
    Opt.SNR      = 200;     % SNR level
    Opt.SScheck  = 1;       % 0 or 1, check steady state
    Opt.SStol    = 1.0e-05; % Steady state tolerance
    Opt.Reset    = 0;       % Reset M to equalibrium?
end