classdef (TestTags = {'SPGR', 'Sensitivity', 'Integration'}) calcSensitivity_Test < matlab.unittest.TestCase

    properties
        qMT5Params
        paramOfInterest
        sensitivityOfInterest
        zSpectrum
        d_zSpectrum
        Prot
    end

    methods (TestClassSetup)
         function simulateSignal(testCase)
            %                                         [F     kf    R1f   T2f    T2r      ]
            testCase.qMT5Params                     = [0.122 3.97  0.9   0.0272 1.096e-05];
            testCase.paramOfInterest                = [1     0     0     0      0        ];

            [testCase.sensitivityOfInterest, testCase.zSpectrum, testCase.d_zSpectrum, testCase.Prot] = calcSensitivity(testCase.qMT5Params, testCase.paramOfInterest, 'UK_3T.mat');
         end
    end

    methods (TestClassTeardown)

    end

    methods (Test)
        function test_sensitivityOfInterest_length_is_same_as_zSpectrum(testCase)

            testCase.verifyEqual(length(testCase.sensitivityOfInterest), length(testCase.zSpectrum))

        end

        function test_zSpectrum_length_is_same_as__d_zSpectrum(testCase)

            testCase.verifyEqual(length(testCase.zSpectrum), length(testCase.d_zSpectrum))

        end

        function test_sensitivityOfInterest_is_proper_value_rel_to_zS_and__d_zS(testCase)
            deltaPerc = 10^-2;
            testCase.verifyEqual( testCase.sensitivityOfInterest, (testCase.d_zSpectrum - testCase.zSpectrum)                         ...
                                                                                        /                                             ...
                                                    ( testCase.qMT5Params(logical( testCase.paramOfInterest ))*(deltaPerc/100) )      ...
                                )
        end
    end

end

