classdef (Abstract = true) SeqOptimization < handle
    %SEQOPTIMIZATION Abstract class to optimize an MRI pulse sequence
    %

    properties (Access = protected)
    end

    methods (Access = public)
        % Constructor
        % Must be explicitely called in all subclass constructors prior to
        % handling the object.
        % e.g. obj = obj@SeqOptimization();
        
        function obj = SeqOptimization()
        end
    end

    methods (Access = protected)
    end

    methods (Static, Access = public)
    end

end
