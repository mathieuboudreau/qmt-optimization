classdef (TestTags = {'SPGR', 'Unit'}) SPGR_FitOpts_Test < matlab.unittest.TestCase

    properties
        demoFitOpts = 'savedfitopts/demo_SPGR_FitOpts_for_UnitTest.mat';

        outputFitOptsFileName = 'savedfitopts/tmp.mat';
    end

    methods (TestClassSetup)

    end

    methods (TestClassTeardown)
        function removeTempFiles(testCase)
            if(exist(testCase.outputFitOptsFileName, 'file'))
                delete(testCase.outputFitOptsFileName)
            end
        end
    end

    methods (Test)
        function test_SPGR_FitOpts_self_class_instance(testCase)
            assertInstanceOf(testCase, SPGR_FitOpts(testCase.demoFitOpts), 'SPGR_FitOpts');
        end

        function test_SPGR_FitOpts_parent_class_instance(testCase)
            assertInstanceOf(testCase, SPGR_FitOpts(testCase.demoFitOpts), 'SeqFitOpts');
        end
        
        % Get Methods
        function test_SPGR_FitOpts_getFitOpts_returns_same_struct_as_input_mat(testCase)
            matFitOpts_struct = load(testCase.demoFitOpts);

            tmpFitOpts_obj = SPGR_Protocol(testCase.demoFitOpts);

            assertEqual(testCase, matFitOpts_struct, tmpFitOpts_obj.getProtocol);

        end
        
         function test_SPGR_FitOpts_save_method_stores_a_mat_file_and_filename(testCase)

            tmpFitOpts_obj = SPGR_FitOpts(testCase.demoFitOpts);
            tmpFitOpts_obj.save(testCase.outputFitOptsFileName);

            assert(logical(exist(testCase.outputFitOptsFileName, 'file')));

         end

         function test_SPGR_FitOpts_saved_protocol_is_same_that_was_loaded(testCase)

            tmpFitOpts_obj = SPGR_FitOpts(testCase.demoFitOpts);
            tmpFitOpts_obj.save(testCase.outputFitOptsFileName);

            savedFitOpts_obj = SPGR_FitOpts(testCase.outputFitOptsFileName);

            tmpFitOpts   = tmpFitOpts_obj.getFitOpts;
            savedFitOpts = savedFitOpts_obj.getFitOpts;

            % Protocol filename won't match (isn't supposed to), so clear
            % before testing.
            tmpFitOpts.FileName = [];
            savedFitOpts.FileName = [];

            assertEqual(testCase, tmpFitOpts, savedFitOpts);

         end

         
         % Set Methods
         function test_SPGR_FitOpts_setFitVar_throws_error_for_unknown_varName(testCase)

            tmpFitOpts_obj = SPGR_FitOpts(testCase.demoFitOpts);
            
            testError.identifier='No Error';
            try
                tmpFitOpts_obj.setFitVar('wrongType', 1);
            catch ME
                testError = ME;
            end
            
            assertEqual(testCase, testError.identifier, 'SPGR_FitOpts:unknownFitVarName');
            
         end

         function test_SPGR_FitOpts_setFitVar_throws_error_for_bad_var_type(testCase)
             
             tmpFitOpts_obj = SPGR_FitOpts(testCase.demoFitOpts);
             
             varName = SPGR_FitOpts.fitVars{6}; % 'fx', bool
             badVarVal = single([false false false true false false]);
             
             testError.identifier='No Error';
             try
                 tmpFitOpts_obj.setFitVar(varName, badVarVal);
             catch ME
                 testError = ME;
             end
             
             assertEqual(testCase, testError.identifier, 'SPGR_FitOpts:wrongVarValueType');
             
         end
         
         function test_SPGR_FitOpts_setFitVar_sets_value_correctly(testCase)
             
             tmpFitOpts_obj = SPGR_FitOpts(testCase.demoFitOpts);
             
             varName = SPGR_FitOpts.fitVars{6}; % 'fx', bool
             varVal = [true false false true false true];
             
             % Set value
             tmpFitOpts_obj.setFitVar(varName, varVal);
             
             %Get protocol
             fitProt = tmpFitOpts_obj.getFitOpts();
             
             assertEqual(testCase, fitProt.(SPGR_FitOpts.fitVars{6}), varVal);
             
         end
    end

end
