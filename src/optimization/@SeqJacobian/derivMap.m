function signVal = derivMap(mapType)
%DERIVMAP Return the sign that corresponds with the derivative type
%
% 'forward' corresponds to ( f(x+h)-f(x) )/h
% 'backward' corresponds to ( f(x)-f(x-h) )/h

    switch mapType
        case 'forward'
            signVal = +1;
        case 'backward'
            signVal = -1;
        otherwise
            error('derivMap:incorrectArg', 'Argument must be string with a value of either ''forward'' or ''backward''. ')
    end
end