classdef (TestTags = {'SPGR', 'Unit'}) SPGR_Optimization_Test < matlab.unittest.TestCase

    properties
    	demoJacobian = 'savedjacobians/test_jacobian.mat';
        demoOpts = struct('fitParams', {{'F', 'kf', 'T2f', 'T2r'}});
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

         function test_getRankedAcqPoints_returns_0s_after_initialization(testCase)

             load(testCase.demoJacobian, 'jacobianObj');
             optObj = SPGR_Optimization(jacobianObj, testCase.demoOpts);

             rankedAcqPoints = optObj.getRankedAcqPoints();

             assertFalse(testCase, any(rankedAcqPoints));
         end
         
         function test_getMetricValsAcqPoints_returns_nans_after_initialization(testCase)

             load(testCase.demoJacobian, 'jacobianObj');
             optObj = SPGR_Optimization(jacobianObj, testCase.demoOpts);

             metricValsAcqPoints = optObj.getMetricValsAcqPoints();

             assertTrue(testCase, all( isnan(metricValsAcqPoints) ));
         end

         
         function test_getRankedAcqPoints_returns_NO_0s_after_initialization(testCase)

             load(testCase.demoJacobian, 'jacobianObj');
             optObj = SPGR_Optimization(jacobianObj, testCase.demoOpts);

             optObj.iterOptim();
             
             rankedAcqPoints = optObj.getRankedAcqPoints();

             assertTrue(testCase, all(rankedAcqPoints));
         end
         
         function test_getMetricValsAcqPoints_returns_NO_nans_after_initiali(testCase)

             load(testCase.demoJacobian, 'jacobianObj');
             optObj = SPGR_Optimization(jacobianObj, testCase.demoOpts);
             
             optObj.iterOptim();

             metricValsAcqPoints = optObj.getMetricValsAcqPoints();

             assertFalse(testCase, any( isnan(metricValsAcqPoints) ));
         end
    end

end
