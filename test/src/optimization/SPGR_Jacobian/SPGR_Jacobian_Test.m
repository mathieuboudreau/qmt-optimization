classdef (TestTags = {'SPGR', 'Unit'}) SPGR_Jacobian_Test < matlab.unittest.TestCase

    properties
        demoProtocol = 'savedprotocols/demo_SPGR_Protocol_for_UnitTest.mat';
        demoTissue = [1 2 3 4 5 6];
        
        expected_genParamStruct_Fields={'keys','values','differentials'}
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
        function test_genParamStruct_returns_struct_with_correctly_named_fields(testCase)
            testObject = SPGR_Jacobian(SPGR_Protocol(testCase.demoProtocol), SPGR_Tissue(testCase.demoTissue));

            testParamStruct = testObject.genParamStruct();

            for ii=1:length(testCase.expected_genParamStruct_Fields)
                expectedField = testCase.expected_genParamStruct_Fields{ii};

                assert(isfield(testParamStruct, expectedField))
            end
        end

        function test_genParamStruct_contains_expected_keys(testCase)
            tissueObject = SPGR_Tissue(testCase.demoTissue);
            
            testObject = SPGR_Jacobian(SPGR_Protocol(testCase.demoProtocol), tissueObject);
            testParamStruct = testObject.genParamStruct();

            for ii=1:length(tissueObject.paramsKeys)
                assert(any(ismember(testParamStruct.keys,tissueObject.paramsKeys(ii))))
            end
        end

        function test_genParamStruct_contains_expected_values(testCase)
            tissueObject = SPGR_Tissue(testCase.demoTissue);

            testObject = SPGR_Jacobian(SPGR_Protocol(testCase.demoProtocol), tissueObject);
            testParamStruct = testObject.genParamStruct();

            for ii=1:length(tissueObject.paramsKeys)
                keyVal = cell2mat(tissueObject.paramsKeys(ii));
                assertEqual(testCase, testParamStruct.values(keyVal),tissueObject.getParameter(keyVal))
            end
        end

        function test_genParamStruct_contains_expected_differentials(testCase)
            tissueObject = SPGR_Tissue(testCase.demoTissue);

            testObject = SPGR_Jacobian(SPGR_Protocol(testCase.demoProtocol), tissueObject);
            testParamStruct = testObject.genParamStruct();
            differentialFactor = 10^(-2)./100; % 10^-2 % should be default.

            for ii=1:length(tissueObject.paramsKeys)
                keyVal = cell2mat(tissueObject.paramsKeys(ii));
                assertEqual(testCase, testParamStruct.differentials(keyVal), tissueObject.getParameter(keyVal).*differentialFactor)
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

    end

end
