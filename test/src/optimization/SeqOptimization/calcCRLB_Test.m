classdef (TestTags = {'Unit'}) calcCRLB_Test < matlab.unittest.TestCase

    properties
    end
    
    methods (TestClassSetup)
    end
    
    methods (TestClassTeardown)
    end
    
    methods (Test)
         function test_calcFIM_returns_expected_dims(testCase)

             jacobianMat=rand(5,3);
             crlb = SeqOptimization.calcCRLB(jacobianMat);
             assertEqual(testCase, size(crlb), [1 3]);

         end

    end

end
