function derivValues = calcDerivative(obj, func_x, func_x_delta, delta)
%calcDerivative Evaluate the numerical differentiation.
%   func_x_delta = f(x)
%   func_x_delta = f(x+h) "forward", f(x-h) "backward"
%   delta = h

    switch obj.derivMapDirection
        case 'forward'
            derivValues = (func_x_delta - func_x) ./ delta;
        case 'backward'
            derivValues = (func_x - func_x_delta) ./ delta;
    end             

end

