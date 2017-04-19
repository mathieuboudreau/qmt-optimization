classdef (Abstract = true) TissueParams < handle
    %TISSUEPARAMS Abstract class for quantitative tissue parameters
    %
    %   Save and load methods deal strictly at importing/exporting the
    %   tissue parameter values from/to external files.
    %
    %   getParams should give the objects tissue parameters in a
    %   human redable format for the user.

    properties (Access = protected)
        params
    end

    methods (Access = public)
        % Save/Load object
        save(obj, fileName)
            % **Abstract**
            load(obj, fileName)

        % Set/Get methods
            % **Abstract**
            getParams(obj)
            getParameter(obj, paramKey);
    end

end
