function noisyDataset = genNoisyDataset(obj, snrLevel, numPoints)
%GENNOISYDATASET Summary of this function goes here
%   Detailed explanation goes here

    for ii = 1:numPoints %Need a for loop, because addNoise needs to be 
                         %called repeatedly so that the M0 noise levels are
                         %unique.
        noisyDataset(:,ii) = obj.addNoise(snrLevel);
    end
    
    obj.noisyDataset = noisyDataset;
end
