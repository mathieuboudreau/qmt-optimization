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
         %% Initialization Tests
         %
         
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

         function test_SPGR_MonteCarlo_doesnt_throw_error_during_proper_initiali(testCase)
             testError.identifier='No Error';
             
             try 
                 SPGR_MonteCarlo(SPGR_Protocol(testCase.demoProtocol), SPGR_Tissue(testCase.demoTissue))
             catch ME
                 testError = ME;
             end
            
             assertEqual(testCase, testError.identifier, 'No Error');
         end

         %% Get Methods Test
         %
         
         function test_SPGR_MonteCarlo_getNoiselessSignal_returns_expected_dims(testCase)
             protocolObj = SPGR_Protocol(testCase.demoProtocol);
             tissueObj = SPGR_Tissue(testCase.demoTissue);
             
             MCobj = SPGR_MonteCarlo(protocolObj, tissueObj);
             
             
             prot = protocolObj.getProtocol();
             
             if size(prot.Angles) == size(prot.Offsets)
                numMeas = size(prot.Angles);
             else
                 error('Unexpected protocol structure format; size of Angles and Offsets not equal.')
             end
                          
             assertEqual(testCase, numMeas, size(MCobj.getNoiselessSignal()));
         end
         
         %% Generate Tests
         %

         function test_SPGR_MonteCarlo_genNoisyDataset_returns_expected_dims(testCase)
             protocolObj = SPGR_Protocol(testCase.demoProtocol);
             tissueObj = SPGR_Tissue(testCase.demoTissue);
             
             MCobj = SPGR_MonteCarlo(protocolObj, tissueObj);
             
             
             snrVal = 150;
             numPoints = 10000;
             noisyDataSet = MCobj.genNoisyDataset(snrVal, numPoints);
             
             assertEqual(testCase, [size(MCobj.getNoiselessSignal(), 1), numPoints], size(noisyDataSet))
         end
    end

end
