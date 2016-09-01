classdef (TestTags = {'SPGR', 'Demo', 'Integration'}) SPGR_SimDemoTest < matlab.unittest.TestCase

    properties
       qmtlabPath
    end
    methods (TestClassSetup)
        function addqMTLabToPath(testCase)
            parts   = strsplit(pwd, '/');
            parts = parts(1:(end-3));
            parts{end+1} = 'qMTLab';
            testCase.qmtlabPath = strjoin(parts, '/');

            addpath(genpath(testCase.qmtlabPath));
        end
    end

    methods (TestClassTeardown)
        function removeqMTLabFromPath(testCase)
            clear all, close all
        end
    end

    methods (Test)
        function testFittedParamsNearInputValues(testCase)
            run([testCase.qmtlabPath, '/SPGR/SimDemo.m'])

            inputParams  = Sim.Param;
            outputParams = SimCurveResults;

            inputArr  = [inputParams.F  inputParams.kf  inputParams.R1f  inputParams.T2f  inputParams.T2r];
            outputArr = [outputParams.F outputParams.kf outputParams.R1f outputParams.T2f outputParams.T2r];

            %                                                 , # percent
            %                                                 . [F  kf R1f T2f T2r]
            testCase.verifyLessThan(pDiff(inputArr, outputArr), [10 30 10  10  10]);
        end
    end

end

function value = pDiff(inputVal, outputVal)
    value = abs((outputVal-inputVal)./inputVal).*100;
end
