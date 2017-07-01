function noisySignal = addNoise(obj, snrLevel)
%ADDNOISE Add noise to the noiseless signal property, and store it to the noisySignal property.
%   Detailed explanation goes here
    
    noisySignal = addNoise(obj.noiselessSignal, snrLevel, 'mt'); % qMRLab function

end

