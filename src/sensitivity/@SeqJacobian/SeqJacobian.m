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
        jacobianMat
    end

    properties (Constant, Access = public)
        badFirstArgType_id = 'SeqJacobian:missingClass';
        badFirstArgType_msg = 'First input argument to SeqJacobian subclasses must be an object that has a parent class of type ''SeqProtocol''';
        
        badSecondArgType_id = 'TissueParams:missingClass';
        badSecondArgType_msg = 'Second input argument to SeqJacobian subclasses must be an object that has a parent class of type ''T''';
    end

    methods (Access = public)
        % Constructor
        % Must be explicitely called in all subclass constructors prior to
        % handling the object.
        % e.g. obj = obj@SeqJacobian(SeqProtocolInstance, TissueParamsInstance);
        
        function obj = SeqJacobian(SeqProtocolInstance, TissueParamsInstance)
            assert(isa(SeqProtocolInstance, 'SeqProtocol'), SeqJacobian.badFirstArgType_id, SeqJacobian.badFirstArgType_msg)
            assert(isa(TissueParamsInstance, 'TissueParams'), SeqJacobian.badSecondArgType_id, SeqJacobian.badSecondArgType_msg)
        end
    end
    
    methods (Abstract = true, Access = public)

    end

end

