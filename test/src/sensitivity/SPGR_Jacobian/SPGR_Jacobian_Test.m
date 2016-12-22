classdef (TestTags = {'SPGR', 'Unit'}) SPGR_Jacobian_Test < matlab.unittest.TestCase

    properties
        demoProtocol = 'savedprotocols/demo_SPGR_Protocol_for_UnitTest.mat';
        demoTissue = [1 2 3 4 5 6];
    end
    
    methods (TestClassSetup)
    end
    
    methods (TestClassTeardown)
    end
    
    methods (Test)
         function test_SPGR_Jacbobian_throws_error_for_bad_arg_parent_types(testCase)
                          
             % Bad first argument parent type
             testError.identifier='No Error';
             try 
                 SPGR_Jacobian('wrongType', SPGR_Tissue(testCase.demoTissue))
             catch ME
                 testError = ME;
             end
             
             assertEqual(testCase, testError.identifier, SeqJacobian.badFirstArgType_id);

             % Bad second argument parent type
             clear testError
             testError.identifier='No Error';
             try 
                 SPGR_Jacobian(SPGR_Protocol(testCase.demoProtocol), 'wrongType')
             catch ME
                 testError = ME;
             end

             assertEqual(testCase, testError.identifier, SeqJacobian.badSecondArgType_id);

         end

         
         
        % Static Methods
        function test_SPGR_Tissue_method_derivMap_returns_expected_values(testCase)
            
            assertEqual(testCase, SPGR_Jacobian.derivMap('forward'), 1);
            assertEqual(testCase, SPGR_Jacobian.derivMap('backward'), -1);

        end
        
        function test_SPGR_Tissue_method_derivMap_throws_error_for_bad_case(testCase)

            testError.identifier='No Error';
            try 
                SPGR_Jacobian.derivMap('Non-existing case')
            catch ME
                testError = ME;
            end

            assertEqual(testCase, testError.identifier, 'derivMap:incorrectArg');

        end
    end

end
