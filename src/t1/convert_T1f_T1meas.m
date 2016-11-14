function returnVal = convert_T1f_T1meas(params, modeFlag)
%CONVERT_T1F_T1MEAS Converts between the T1 of the free pool T1f (of qMT
%two-pool model) and the measurable T1 value using conventional T1 mapping
%techniques.
%
%   --args--
%   params:1x4 array of parameters needed to do conversion. Flag-dependent.
%       Flag 't1f_2_t1meas': [F kf T1f T1r]
%       Flag 't1meas_2_t1f': [F kf T1meas T1f]
%       
%       ***Note that T1 values are in seconds, and kf in s^-1.
%
%   modeFlag: String.
%       't1f_2_t1meas': convert from known T1f value to T1meas.
%       't1meas_2_t1f': convert from known T1meas value to T1f.

    if (strcmp(modeFlag, 't1f_2_t1meas'))
        F = params(1);
        kf = params(2);
        T1f = params(3);
        T1r = params(4);

        T1meas= T1f_2_T1meas(F, kf, T1f, T1r);
        returnVal = T1meas;
    elseif (strcmp(modeFlag, 't1meas_2_t1f'))
        F = params(1);
        kf = params(2);
        T1meas = params(3);
        T1r = params(4);
        
        T1f = T1meas_2_T1f(F, kf, T1meas, T1r);
        returnVal = T1f;
    else
        error('Invalid flag');    
    end

end

function T1meas= T1f_2_T1meas(F, kf, T1f, T1r)
    R1f = 1/T1f;
    R1r = 1/T1r;

    a=1;
    b=(kf/F)-R1r+R1f+kf;
    c=-(kf/F)*(R1r-R1f);

    r1p=R1r-(-b+sqrt(b^2-4*a*c))/(2*a);

    T1meas=1/r1p;

end


function T1f = T1meas_2_T1f(F, kf, T1meas, T1r)
    R1r = 1/T1r;

    rd = R1r - 1/T1meas;
    R1f = 1/T1meas  - kf * rd /(rd + (kf/F));
    
    T1f = 1/R1f;

end