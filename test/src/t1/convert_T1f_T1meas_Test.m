classdef (TestTags = {'SPGR', 'Unit'}) convert_T1f_T1meas_Test < matlab.unittest.TestCase

    properties

    end

    methods (TestClassSetup)
    end

    methods (TestClassTeardown)

    end

    methods (Test)
        function testgenerateThatConvertingBothWaysReturnsInitialValue(testCase)

            %               [F   kf T1f   T1r ]
            defaultParams = [0.1 3  0.935 1   ];
            
            
            
            T1meas = convert_T1f_T1meas(defaultParams, 't1f_2_t1meas');
            
             %             [F   kf T1meas         T1r ]
            t1measParams = [0.1 3  T1meas 1   ];

            T1f = convert_T1f_T1meas(t1measParams, 't1meas_2_t1f');
        
            testCase.verifyEqual(defaultParams(3), T1f, 'AbsTol', 10^-15);
        end
    end

end

