classdef (TestTags = {'SPGR', 'Unit'}) SPGR_Jacobian_Test < matlab.unittest.TestCase

    properties
        demoProtocol = 'savedprotocols/demo_SPGR_Protocol_for_UnitTest.mat';
        demoTissue = [1 2 3 4 5 6];
        
        expected_genTissueJacStruct_Fields={'keys','value','differential'}
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
             
             assertEqual(testCase, testError.identifier, 'SeqJacobian:missingClass');

             % Bad second argument parent type
             clear testError
             testError.identifier='No Error';
             try 
                 SPGR_Jacobian(SPGR_Protocol(testCase.demoProtocol), 'wrongType')
             catch ME
                 testError = ME;
             end

             assertEqual(testCase, testError.identifier, 'TissueParams:missingClass');

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
        
        % Get methods
        function test_getJacobian_returns_a_type_double_variable(testCase)
            testObject = SPGR_Jacobian(SPGR_Protocol(testCase.demoProtocol), SPGR_Tissue(testCase.demoTissue));
            assertInstanceOf(testCase, testObject.getJacobian, 'double');
        end
        
        % Generate methods
        function test_genTissueJacStruct_returns_struct_with_named_fields(testCase)
            testObject = SPGR_Jacobian(SPGR_Protocol(testCase.demoProtocol), SPGR_Tissue(testCase.demoTissue));

            testParamStruct = testObject.genTissueJacStruct();

            for ii=1:length(testCase.expected_genTissueJacStruct_Fields)
                expectedField = testCase.expected_genTissueJacStruct_Fields{ii};

                assert(isfield(testParamStruct, expectedField))
            end
        end

        function test_genTissueJacStruct_contains_expected_keys(testCase)
            tissueObject = SPGR_Tissue(testCase.demoTissue);
            
            testObject = SPGR_Jacobian(SPGR_Protocol(testCase.demoProtocol), tissueObject);
            testParamStruct = testObject.genTissueJacStruct();

            for ii=1:length(tissueObject.fitParamsKeys)
                assert(any(ismember(testParamStruct.keys,tissueObject.fitParamsKeys(ii))))
            end
        end

        function test_genTissueJacStruct_contains_expected_values(testCase)
            tissueObject = SPGR_Tissue(testCase.demoTissue);

            testObject = SPGR_Jacobian(SPGR_Protocol(testCase.demoProtocol), tissueObject);
            testParamStruct = testObject.genTissueJacStruct();

            for ii=1:length(tissueObject.fitParamsKeys)
                keyVal = cell2mat(tissueObject.fitParamsKeys(ii));
                assertEqual(testCase, testParamStruct.value(keyVal),tissueObject.getParameter(keyVal))
            end
        end

        function test_genTissueJacStruct_contains_expected_differentials(testCase)
            tissueObject = SPGR_Tissue(testCase.demoTissue);

            testObject = SPGR_Jacobian(SPGR_Protocol(testCase.demoProtocol), tissueObject);
            testParamStruct = testObject.genTissueJacStruct();
            differentialFactor = 10^(-2)./100; % 10^-2 % should be default.

            for ii=1:length(tissueObject.fitParamsKeys)
                keyVal = cell2mat(tissueObject.fitParamsKeys(ii));
                assertEqual(testCase, testParamStruct.differential(keyVal), tissueObject.getParameter(keyVal).*differentialFactor)
            end
        end
        
        % Methods for Jacobian computation
        function test_compute_returns_error_for_unkown_computOpts_mode(testCase)
            testObject = SPGR_Jacobian(SPGR_Protocol(testCase.demoProtocol), SPGR_Tissue(testCase.demoTissue));
            computeOpts.mode = 'UnKn0wnM0dE';
            
            % Preload testError for test
            testError.identifier='No Error';
            try 
                testObject.compute(computeOpts);
            catch ME
                testError = ME;
            end
            
            assertEqual(testCase, testError.identifier, 'SPGR_Jacobian:unknownComputeMode');
        end

        function test_compute_throws_warning_when_computeOpts_mode_is_Completed(testCase)
            testObject = SPGR_Jacobian(SPGR_Protocol(testCase.demoProtocol), SPGR_Tissue(testCase.demoTissue));
            computeOpts.mode = 'Completed';
            
            % Reset the last warning to a new string
            warning('Temporary warning for unit test of SPGR_Jacobian.compute')

            testObject.compute(computeOpts);

            assertEqual(testCase, lastwarn, 'computeOpts.mode flag was set to Completed, obj.compute returned without further computation of Jacobian.');
        end


        function test_compute_compOpts_and_jacStruct_unchanged_for_Completed(testCase)
            testObject = SPGR_Jacobian(SPGR_Protocol(testCase.demoProtocol), SPGR_Tissue(testCase.demoTissue));
            computeOpts.mode = 'Completed';
            
            prev_computeOpts = computeOpts;
            prev_jacobianMat = testObject.getJacobian();
            
            computeOpts = testObject.compute(computeOpts);

            assertEqual(testCase,              computeOpts, prev_computeOpts);            
            assertEqual(testCase, testObject.getJacobian(), prev_jacobianMat);

        end

        function test_compute_New_returns_Resume_or_Completed(testCase)
            testObject = SPGR_Jacobian(SPGR_Protocol(testCase.demoProtocol), SPGR_Tissue(testCase.demoTissue));
 
            computeOpts.mode = 'New';
            computeOpts.paramsOfInterest = {'F', 'kf', 'T1f', 'T2r', 'T2f'};
            computeOpts.lineBuffer = 2;

            computeOpts = testObject.compute(computeOpts);

            assertTrue(testCase, any(ismember({'Resume', 'Complete'}, computeOpts.mode)));            
        end

        function test_compute_Resume_returns_Resume_or_Completed(testCase)
            testObject = SPGR_Jacobian(SPGR_Protocol(testCase.demoProtocol), SPGR_Tissue(testCase.demoTissue));
 
            computeOpts.mode = 'Resume';
            computeOpts.paramsOfInterest = {'F', 'kf', 'T1f', 'T2r', 'T2f'};
            computeOpts.lineBuffer = 2;

            computeOpts = testObject.compute(computeOpts);

            assertTrue(testCase, any(ismember({'Resume', 'Complete'}, computeOpts.mode)));            
        end

        function test_compute_New_sets_up_a_jacobian_template_with_proper_dims(testCase)
           protocolObj = SPGR_Protocol(testCase.demoProtocol);
            
           testObject = SPGR_Jacobian(protocolObj, SPGR_Tissue(testCase.demoTissue));

           computeOpts.mode = 'New';
           computeOpts.paramsOfInterest = {'F', 'kf', 'T1f', 'T2r', 'T2f'};
           computeOpts.lineBuffer = 2;

           computeOpts = testObject.compute(computeOpts);

           expectedJacobianSize = [protocolObj.getNumberOfMeas length(computeOpts.paramsOfInterest)];
           assertEqual(testCase, size(testObject.getJacobian), expectedJacobianSize);            
        end
       
        function test_compute_lineBuffer_larger_than_rem_array_doesnt_error(testCase)
           protocolObj = SPGR_Protocol(testCase.demoProtocol);
            
           testObject = SPGR_Jacobian(protocolObj, SPGR_Tissue(testCase.demoTissue));

           computeOpts.mode = 'New';
           computeOpts.paramsOfInterest = {'F', 'kf', 'T1f', 'T2r', 'T2f'};
           computeOpts.lineBuffer = protocolObj.getNumberOfMeas + 1;

           testObject.compute(computeOpts); % Can't currently think of an assert for this test, but if this call throws an error, the test will fail as intended.       
       end
        
    end

end
