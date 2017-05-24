classdef (TestTags = {'Unit'}) calcFIM_Test < matlab.unittest.TestCase

    properties
    end
    
    methods (TestClassSetup)
    end
    
    methods (TestClassTeardown)
    end
    
    methods (Test)
         function test_calcFIM_returns_expected_dims(testCase)

             jacobianMat=rand(5,3);
             fisherInformation = SeqOptimization.calcFIM(jacobianMat);
             assertEqual(testCase, size(fisherInformation), [3 3]);

         end

    end

end
