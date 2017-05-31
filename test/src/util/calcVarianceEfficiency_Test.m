classdef (TestTags = {'Unit'}) calcVarianceEfficiency_Test < matlab.unittest.TestCase

    properties
    end

    methods (TestClassSetup)
    end

    methods (TestClassTeardown)
    end

    methods (Test)
        function test_varianceEfficiency_throws_error_for_0_timeVals(testCase)

            % varianceEfficiency = calcVarianceEfficiency();
            timeVals = [0;1;2;3;4];
            varianceVals = [1000;2000;3000;4000;5000];
            
            testCase.assertError(@() calcVarianceEfficiency(timeVals, varianceVals), 'calcVarianceEfficiency:zerosInArgs');
        end
        
        function test_varianceEfficiency_throws_error_for_0_varianceVals(testCase)

            % varianceEfficiency = calcVarianceEfficiency();
            timeVals = [1;2;3;4;5];
            varianceVals = [1000; 0;3000;4000;5000];
            
            testCase.assertError(@() calcVarianceEfficiency(timeVals, varianceVals), 'calcVarianceEfficiency:zerosInArgs');
        end
        
        function test_varianceEfficiency_example_case(testCase)

            % varianceEfficiency = calcVarianceEfficiency();
            timeVals = [6; 8; 10; 12; 14];
            varianceVals = [6773.37770994125;2463.64929867767;1794.95778833628;1311.05466184621;1139.41751857526];
            
            testCase.assertEqual(1./sqrt(varianceVals.*timeVals), calcVarianceEfficiency(timeVals, varianceVals))
        end
    end

end

