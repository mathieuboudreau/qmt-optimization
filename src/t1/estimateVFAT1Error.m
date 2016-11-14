function [T1errorVal, measuredSignal, Sy, Sx] = estimateVFAT1Error(T1, TR, FAs, B1ErrorRange)
%ESTIMATEVFAT1ERROR Estimates the error in fitted VFA T1 value
%   T1: scalar in ms or s
%   TR: scalar in ms or s
%   FAs: array in deg
%   B1ErrorRange: array in relative amplitude. True value is 1.

M0 = 10;
measuredSignal = vfaSignal(T1, TR, FAs, M0);

for ii=1:length(B1ErrorRange)
    Sy = measuredSignal./sind(FAs.*B1ErrorRange(ii));
    Sx = measuredSignal./tand(FAs.*B1ErrorRange(ii));

    p=polyfit(Sx,Sy,1);

    T1errorVal(ii) = -TR./log(p(1));
end

end
