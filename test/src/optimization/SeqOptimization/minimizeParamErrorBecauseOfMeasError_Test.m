classdef (TestTags = {'Unit'}) minimizeParamErrorBecauseOfMeasError_Test < matlab.unittest.TestCase

    properties
    end
    
    methods (TestClassSetup)
    end
    
    methods (TestClassTeardown)
    end
    
    methods (Test)
         function test_minParmErrorBecOfMeasErr_returns_correct_dims(testCase)

             A=rand(5,3);
             b=[1 2 3 4 5]';
             paramError = SeqOptimization.minimizeParamErrorBecauseOfMeasError(A, b, 0.05);
             assertEqual(testCase, size(paramError), [3 1]);

         end

    end

end
