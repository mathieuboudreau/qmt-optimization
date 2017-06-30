classdef (TestTags = {'SPGR', 'Unit'}) SPGR_MonteCarlo_Test < matlab.unittest.TestCase

    properties
        demoProtocol = 'savedprotocols/demo_SPGR_Protocol_for_UnitTest.mat';
        demoTissue = [0.122 3.97 1.1111 1 0.0272 1.0960e-05];
    end
    
    methods (TestClassSetup)

    end
    
    methods (TestClassTeardown)

    end
    
    methods (Test)
         function test_SPGR_MonteCarlo_throws_error_for_bad_arg_parent_types(testCase)
                          
             % Bad first argument parent type
             testError.identifier='No Error';
             try 
                 SPGR_MonteCarlo('wrongType', SPGR_Tissue(testCase.demoTissue))
             catch ME
                 testError = ME;
             end
             
             assertEqual(testCase, testError.identifier, 'SeqJacobian:missingClass');

             % Bad second argument parent type
             clear testError
             testError.identifier='No Error';
             try 
                 SPGR_MonteCarlo(SPGR_Protocol(testCase.demoProtocol), 'wrongType')
             catch ME
                 testError = ME;
             end

             assertEqual(testCase, testError.identifier, 'TissueParams:missingClass');

         end

    end

end
