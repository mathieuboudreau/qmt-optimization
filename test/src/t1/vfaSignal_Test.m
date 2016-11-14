classdef (TestTags = {'VFA', 'Unit'}) vfaSignal_Test < matlab.unittest.TestCase

    properties

    end

    methods (TestClassSetup)
    end

    methods (TestClassTeardown)

    end

    methods (Test)
        function testVFASignal_gives_expected_signal_for_3deg(testCase)

            T1 = 900; % ms
            TR = 15;  % ms
            FA = 3;   % deg
            M0 = 10;  % Unitless
            
            expectedSignal = 0.483900127130478;
            testCase.verifyEqual(vfaSignal(T1, TR, FA, M0), expectedSignal, 'AbsTol', 10^-10);
        end
        
        function testVFASignal_gives_expected_signal_for_20deg(testCase)

            T1 = 900; % ms
            TR = 15;  % ms
            FA = 20;   % deg
            M0 = 10;  % Unitless
            
            expectedSignal = 0.745406174502237;
            testCase.verifyEqual(vfaSignal(T1, TR, FA, M0), expectedSignal, 'AbsTol', 10^-10);
        
        end
        
        function testVFASignal_gives_wrong_signal_for_20deg_in_radians(testCase)

            T1 = 900; % ms
            TR = 15;  % ms
            FAdeg = 20;   % deg
            FA = degtorad(FAdeg);
            M0 = 10;  % Unitless
            
            expectedSignalForDegInput = 0.745406174502237;
            testCase.verifyNotEqual(vfaSignal(T1, TR, FA, M0), expectedSignalForDegInput);
        
        end
    end

end

