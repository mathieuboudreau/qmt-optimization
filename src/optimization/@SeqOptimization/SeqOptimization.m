classdef (Abstract = true) SeqOptimization < handle
    %SEQOPTIMIZATION Abstract class to optimize an MRI pulse sequence
    %

    properties (Access = protected)
        jacobianObj
        opts
    end

    methods (Access = public)
        % Constructor
        % Must be explicitely called in all subclass constructors prior to
        % handling the object.
        % e.g. obj = obj@SeqOptimization();
        
        function obj = SeqOptimization(SeqJacobian_Obj, opts)
        	assert(isa(SeqJacobian_Obj, 'SeqJacobian'), 'SeqOptimization:wrongArgClass', 'First input argument to SeqOptimization subclasses must be an object that has a parent class of type ''SeqJacobian''')
        end
    end

    methods (Access = protected)
    end

    methods (Static, Access = public)
        paramError = minimizeParamErrorBecauseOfMeasError(paramJacMat, measJacMat, measError)
    end

end
