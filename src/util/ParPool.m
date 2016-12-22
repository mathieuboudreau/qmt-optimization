classdef ParPool < handle
    %PARPOOL Singleton class to initiate a parpool session for parallel
    %processing
    %   To begin a session, call the static method ParPool.instance().
    
    properties
        numCores
        poolHandle
    end
    
    methods (Access = protected)
        function obj = ParPool()
              obj.numCores = feature('numCores');
              obj.poolHandle = parpool(obj.numCores);
        end
        
        function delete(obj)
           delete(obj.poolHandle) 
        end
    end
    
    methods (Static, Access = public)
        function obj = instance()
            if(~ParPool.checkExistingSession())
                obj = ParPool();
            else
                disp('A parpool session already exists, skipping initialization.')
                obj = [];
            end
        end
        
        function sessionBool = checkExistingSession()
           sessionBool = ~isempty(gcp('nocreate')); 
        end
    end
    
end
