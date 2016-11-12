classdef (TestTags = {'SPGR', 'Integration'}) generateSignalSPGR_Test < matlab.unittest.TestCase

    properties
        qMT5Params
        zSpectrum_run1
        zSpectrum_run2
        Prot
    end

    methods (TestClassSetup)
         function simulateSignal(testCase)
            %                                         [F     kf    R1f   T2f    T2r      ]
            testCase.qMT5Params                     = [0.122 3.97  0.9   0.0272 1.096e-05];

            [testCase.zSpectrum_run1,            ~] = generateSignalSPGR(testCase.qMT5Params, 'UK_3T.mat');
            [testCase.zSpectrum_run2,testCase.Prot] = generateSignalSPGR(testCase.qMT5Params, 'UK_3T.mat');
         end
    end

    methods (TestClassTeardown)

    end

    methods (Test)
        function test_generateSignalSPGR_run_twice_gives_the_same_output(testCase)

            testCase.verifyEqual(testCase.zSpectrum_run1, testCase.zSpectrum_run2)

        end


        function test_generateSignalSPGR_zSpectrum_match_prot_offset_dim(testCase)

            testCase.verifyEqual(length(testCase.zSpectrum_run1), length(testCase.Prot.Offsets))

        end
    end

end

