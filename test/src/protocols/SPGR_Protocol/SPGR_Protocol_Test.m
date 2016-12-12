classdef (TestTags = {'SPGR', 'Unit'}) SPGR_Protocol_Test < matlab.unittest.TestCase

    properties
        demoProtocol = 'savedprotocols/demo_SPGR_Protocol_for_UnitTest.mat';

        outputProtocolFileName = 'savedprotocols/tmp.mat';
    end

    methods (TestClassSetup)

    end

    methods (TestClassTeardown)
        function removeTempFiles(testCase)
            if(exist(testCase.outputProtocolFileName, 'file'))
                delete(testCase.outputProtocolFileName)
            end
        end
    end

    methods (Test)
        function test_SPGR_Protocol_self_class_instance(testCase)
            assertInstanceOf(testCase, SPGR_Protocol(testCase.demoProtocol), 'SPGR_Protocol');
        end

        function test_SPGR_Protocol_parent_class_instance(testCase)
            assertInstanceOf(testCase, SPGR_Protocol(testCase.demoProtocol), 'SeqProtocol');
        end

        function test_SPGR_Protocol_getProtocol_returns_same_struct_as_input_mat(testCase)
            matProtocol_struct = load(testCase.demoProtocol);

            tmp_prot_obj = SPGR_Protocol(testCase.demoProtocol);

            assertEqual(testCase, matProtocol_struct, tmp_prot_obj.getProtocol);

        end

         function test_SPGR_Protocol_save_method_stores_a_mat_file_and_filename(testCase)

            tmp_prot_obj = SPGR_Protocol(testCase.demoProtocol);
            tmp_prot_obj.save(testCase.outputProtocolFileName);

            assert(logical(exist(testCase.outputProtocolFileName, 'file')));

         end

         function test_SPGR_Protocol_saved_protocol_is_same_that_was_loaded(testCase)

            tmp_prot_obj = SPGR_Protocol(testCase.demoProtocol);
            tmp_prot_obj.save(testCase.outputProtocolFileName);

            saved_prot_obj = SPGR_Protocol(testCase.outputProtocolFileName);

            tmpProtocol   = tmp_prot_obj.getProtocol;
            savedProtocol = saved_prot_obj.getProtocol;

            % Protocol filename won't match (isn't supposed to), so clear
            % before testing.
            tmpProtocol.FileName = [];
            savedProtocol.FileName = [];

            assertEqual(testCase, tmpProtocol, savedProtocol);

         end

         function test_SPGR_Protocol_remove_protocol_point_method(testCase)

            tmp_prot_obj = SPGR_Protocol(testCase.demoProtocol);

            beforeProtocol = tmp_prot_obj.getProtocol;

            beforeOffsetVals = beforeProtocol.Offsets;

            protocolMask = zeros(1,length(beforeOffsetVals));
            protocolMask(end) = 1;

            % Remove point
            tmp_prot_obj.remove(protocolMask);

            afterProtocol = tmp_prot_obj.getProtocol;
            afterOffsetsVals = afterProtocol.Offsets;

            assertEqual(testCase, length(afterOffsetsVals), length(beforeOffsetVals) - 1);
            assertEqual(testCase, afterOffsetsVals, beforeOffsetVals(1:end-1));

         end
    end

end
