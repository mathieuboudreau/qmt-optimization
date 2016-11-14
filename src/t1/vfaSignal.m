function signal = vfaSignal(T1, TR, FA, M0)
% Calculate signal from a Variable Flip Angle experiment (SPGR).
% T1 in ms or seconds
% TR in ms or seconds
% FA in deg ***
% M0 Equilibrium magnetization

    E1 = exp(-TR/T1);
    signal = M0 .* (1-E1)./(1-cosd(FA).*E1) .* sind(FA);

end