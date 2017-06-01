classdef (TestTags = {'Unit'}) IterativeOptimization_Test < matlab.unittest.TestCase

    properties
    	demoJacobian = 'savedjacobians/test_jacobian.mat';
        demoOpts = struct('fitParams', {{'F', 'kf', 'T2f', 'T2r'}}, 'b1Params', {{'B1_IR', 'B1_VFA'}});
    end
    
    methods (TestClassSetup)
    end
    
    methods (TestClassTeardown)
    end
    
    methods (Test)
         function test_IterativeOptimization_throws_error_for_bad_arg_parent_type(testCase)

             % Bad first argument parent type
             testError.identifier='No Error';
             try 
                 IterativeOptimization('wrongType', 0)
             catch ME
                 testError = ME;
             end
             
             assertEqual(testCase, testError.identifier, 'SeqOptimization:wrongArgClass');

         end

         function test_getRankedAcqPoints_returns_0s_after_initialization(testCase)

             load(testCase.demoJacobian, 'jacobianObj');
             optObj = IterativeOptimization(jacobianObj, testCase.demoOpts);

             rankedAcqPoints = optObj.getRankedAcqPoints();

             assertFalse(testCase, any(rankedAcqPoints));
         end
         
         function test_getMetricValsAcqPoints_returns_nans_after_initialization(testCase)

             load(testCase.demoJacobian, 'jacobianObj');
             optObj = IterativeOptimization(jacobianObj, testCase.demoOpts);

             metricValsAcqPoints = optObj.getMetricValsAcqPoints();

             assertTrue(testCase, all( isnan(metricValsAcqPoints) ));
         end

         
         function test_getRankedAcqPoints_returns_not_more_numParam_0s_after_comp(testCase)

             load(testCase.demoJacobian, 'jacobianObj');
             optObj = IterativeOptimization(jacobianObj, testCase.demoOpts);

             optObj.computeSingle('CRLB');
             
             rankedAcqPoints = optObj.getRankedAcqPoints();

             assertTrue(testCase, sum(logical(~rankedAcqPoints)) <= length(testCase.demoOpts.fitParams));
         end
         
         function test_getMetricValsAcqPoints_not_more_numParam_nans_after_comp(testCase)

             load(testCase.demoJacobian, 'jacobianObj');
             optObj = IterativeOptimization(jacobianObj, testCase.demoOpts);
             
             optObj.computeSingle('CRLB');

             metricValsAcqPoints = optObj.getMetricValsAcqPoints();

             assertTrue(testCase,  sum(isnan(metricValsAcqPoints)) <= length(testCase.demoOpts.fitParams) );
         end
         
         function test_computeRegularized_w_0_coeff_ret_same_as_compSingle_CRLB(testCase)

             load(testCase.demoJacobian, 'jacobianObj');
             optObj = IterativeOptimization(jacobianObj, testCase.demoOpts);
             
             optObj.computeSingle('CRLB');
             rankedAcqPoints_single = optObj.getRankedAcqPoints();
             metricValsAcqPoints_single = optObj.getMetricValsAcqPoints();

             optObj.computeRegularized({'CRLB', 'B1_VFA'}, 0);
             rankedAcqPoints_regularized = optObj.getRankedAcqPoints();
             metricValsAcqPoints_regularized = optObj.getMetricValsAcqPoints();
             
             testCase.assertEqual(rankedAcqPoints_single, rankedAcqPoints_regularized);
             testCase.assertEqual(metricValsAcqPoints_single, metricValsAcqPoints_regularized);

         end
         
         function test_computeRegularized_w_0_coeff_ret_same_as_compSingle_B1(testCase)

             load(testCase.demoJacobian, 'jacobianObj');
             optObj = IterativeOptimization(jacobianObj, testCase.demoOpts);
             
             optObj.computeSingle('B1_VFA');
             rankedAcqPoints_single = optObj.getRankedAcqPoints();
             metricValsAcqPoints_single = optObj.getMetricValsAcqPoints();

             optObj.computeRegularized({'B1_VFA', 'CRLB'}, 0);
             rankedAcqPoints_regularized = optObj.getRankedAcqPoints();
             metricValsAcqPoints_regularized = optObj.getMetricValsAcqPoints();
             
             testCase.assertEqual(rankedAcqPoints_single, rankedAcqPoints_regularized);
             testCase.assertEqual(metricValsAcqPoints_single, metricValsAcqPoints_regularized);

         end
    end

end
