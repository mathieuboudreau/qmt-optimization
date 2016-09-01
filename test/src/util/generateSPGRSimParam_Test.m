classdef (TestTags = {'SPGR', 'Unit'}) generateSPGRSimParam_Test < matlab.unittest.TestCase

    properties
       defaultFileName
       defaultFileType
       defaultOpt
       defaultParam
    end

    methods (TestClassSetup)
        function setPath(testCase)
            parts   = strsplit(pwd, '/');
            parts = parts(1:(end-3));
            addpath(genpath(strjoin(parts, '/')));
        end

        function getDefaultSPGRParams(testCase)
            load('qMTLab/SPGR/Parameters/DefaultSim.mat')
            testCase.defaultFileName = FileName;
            testCase.defaultFileType = FileType;
            testCase.defaultOpt      = Opt;
            testCase.defaultParam    = Param;
            clear FileName, clear FileType, clear Opt, clear Param;
        end
    end

    methods (TestClassTeardown)
        function removeqMTLabFromPath(testCase)
            clear all, close all
        end
    end

    methods (Test)
        function testgenerateSPGRSimParam_generates_demo_values(testCase)

            filename          = 'DefaultSim';
            %                   [F   kf R1f T2f  T2r  ]
            defaultqMT5Params = [0.1 3  1   0.04 1e-05];
            noiseFlag         = 1; % Default file has noise

            [outFileName, outFileType, outOpt, outParam] = generateSPGRSimParam(filename, defaultqMT5Params, noiseFlag);

            testCase.verifyEqual(outFileName, testCase.defaultFileName)
            testCase.verifyEqual(outFileType, testCase.defaultFileType)
            testCase.verifyEqual(outOpt     , testCase.defaultOpt)
            testCase.verifyEqual(outParam   , testCase.defaultParam)
        end
    end

end

