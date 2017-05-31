function varianceEfficiency = calcVarianceEfficiency(timeVals, varianceVals)
%CALCVARIANCEEFFICIENCY Calculate the variance efficiency as defined in 
%   Levesque et al. 2001
%   
%   --args--
%       timeVals: "Time"/"Duration" values. See Levesque et al. 2011 for a
%       more in depth application example (e.g. scan time for each
%       varianceVal calculated).
%
%       varianceVals: Variance values (e.g. calculated from Cramer-Rao
%                     Lower Bound.
%   
%   See: Levesque, I. R., Sled, J. G. and Pike, G. B. Iterative 
%   optimization method for design of quantitative magnetization transfer 
%   imaging experiments. Magnetic Resonance in Medicine 66(3): 635-643
%   (2011)

    if any(timeVals == 0) || any(varianceVals == 0)
        error('calcVarianceEfficiency:zerosInArgs', 'Function argument elements cannot contain zeros due to division')
    end

    varianceEfficiency = 1./sqrt(varianceVals.*timeVals);

end
