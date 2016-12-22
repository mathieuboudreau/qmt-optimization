classdef (TestTags = {'Unit'}) ParPool_Test < matlab.unittest.TestCase

    properties
    end

    methods (TestClassSetup)
    end

    methods (TestClassTeardown)
    end

    methods (Test)
        function testParPool_instance_method_creates_new_parpool(testCase)
            assert(~ParPool.checkExistingSession())
            
            ParPool.instance();
            
            assert(ParPool.checkExistingSession())
        end
        
      function testParPool_instance_returns_empty_if_sessions_already_exists(testCase)
            assert(~ParPool.checkExistingSession())
            ParPool.instance();

            assert(isempty(ParPool.instance()))
      end
    end

end

