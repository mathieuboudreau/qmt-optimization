classdef (TestTags = {'SPGR', 'Unit'}) SPGR_Tissue_Test < matlab.unittest.TestCase

    properties
        outputTissueFileName = 'savedtissues/tmp.mat';
        demoTissue = [1 2 3 4 5 6];
        demoTissue2 = [3 4 2 5 6 1];
    end
    
    methods (TestClassSetup)
    end
    
    methods (TestClassTeardown)
        function removeTempFiles(testCase)
            if(exist(testCase.outputTissueFileName, 'file'))
                delete(testCase.outputTissueFileName)
            end
        end
    end
    
    methods (Test)
        function test_SPGR_Tissue_self_class_instance(testCase)
            assertInstanceOf(testCase, SPGR_Tissue(testCase.demoTissue), 'SPGR_Tissue');
        end
        
        function test_SPGR_Tissue_parent_class_instance(testCase)
            assertInstanceOf(testCase, SPGR_Tissue(testCase.demoTissue), 'TissueParams');
        end
        
        function test_SPGR_Tissue_getParams_returns_same_array_as_input_array(testCase)
            tmp_tissue_obj = SPGR_Tissue(testCase.demoTissue);
            
            assertEqual(testCase, testCase.demoTissue, tmp_tissue_obj.getParams);
        end
        
        function test_SPGR_Tissue_getParameter_returns_same_values_as_expected(testCase)
            tmp_tissue_obj = SPGR_Tissue(testCase.demoTissue);
            
            for ii = 1:length(SPGR_Tissue.paramsKeys)
                assertEqual(testCase, tmp_tissue_obj.getParameter(cell2mat(SPGR_Tissue.paramsKeys(ii))), testCase.demoTissue(ii));
            end
        end 
        
        function test_SPGR_Tissue_save_method_stores_a_mat_file_and_filename(testCase)
            
            tmp_tissue_obj = SPGR_Tissue(testCase.demoTissue);
            tmp_tissue_obj.save(testCase.outputTissueFileName);
            
            assert(logical(exist(testCase.outputTissueFileName, 'file')));
            
        end
        
        function test_SPGR_Tissue_saved_tissue_is_same_that_was_loaded(testCase)
            
            tmp_tissue_obj = SPGR_Tissue(testCase.demoTissue);
            
            if(exist(testCase.outputTissueFileName, 'file'))
                delete(testCase.outputTissueFileName)
            end
            
            tmp_tissue_obj.save(testCase.outputTissueFileName);
            
            new_tissue_obj = SPGR_Tissue(testCase.demoTissue2);
            
            assert(~isequal(new_tissue_obj, tmp_tissue_obj), 'Second object created in this test must be different from first created') 
            
            % Load first tissue into this object
            new_tissue_obj.load(testCase.outputTissueFileName);

            assertEqual(testCase, new_tissue_obj, tmp_tissue_obj);
        end

    end

end
