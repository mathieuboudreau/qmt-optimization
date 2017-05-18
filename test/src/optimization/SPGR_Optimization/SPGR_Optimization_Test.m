classdef (TestTags = {'SPGR', 'Unit'}) SPGR_Optimization_Test < matlab.unittest.TestCase

    properties
    end
    
    methods (TestClassSetup)
    end
    
    methods (TestClassTeardown)
    end
    
    methods (Test)
         function test_SPGR_Optimization_throws_error_for_bad_arg_parent_type(testCase)

             % Bad first argument parent type
             testError.identifier='No Error';
             try 
                 SPGR_Optimization('wrongType', 0)
             catch ME
                 testError = ME;
             end
             
             assertEqual(testCase, testError.identifier, 'SeqOptimization:wrongArgClass');

         end

    end

end
