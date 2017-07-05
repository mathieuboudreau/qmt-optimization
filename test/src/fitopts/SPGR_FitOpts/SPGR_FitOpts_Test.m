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

    end

end
