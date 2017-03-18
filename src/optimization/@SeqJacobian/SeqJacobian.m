classdef SeqJacobian < handle
    %SEQJacobian Abstract class to calculate and store Jacobian for an MRI
    %pulse sequence
    %
    %   Save and load methods deal strictly at importing/exporting the
    %   protocol property from/to external files.
    %
    %   getProtocol should give the objects protocol details/variables in a
    %   human redable format for the user.

    properties (Abstract = true, Access = protected)
        protocolObj
        tissueParamsObj
        jacobianStruct
    end

    properties (Constant, Access = public)
    end

    methods (Access = public)
        % Constructor
        % Must be explicitely called in all subclass constructors prior to
        % handling the object.
        % e.g. obj = obj@SeqJacobian(SeqProtocolInstance, TissueParamsInstance);
        
        function obj = SeqJacobian(SeqProtocolInstance, TissueParamsInstance)
            assert(isa(SeqProtocolInstance, 'SeqProtocol'), 'SeqJacobian:missingClass', 'First input argument to SeqJacobian subclasses must be an object that has a parent class of type ''SeqProtocol''')
            assert(isa(TissueParamsInstance, 'TissueParams'), 'TissueParams:missingClass', 'Second input argument to SeqJacobian subclasses must be an object that has a parent class of type ''TissueParams''')
        end
    end
    
    methods (Abstract = true, Access = public)
        remainingRows = getRemainingRows(obj)
    end

end

