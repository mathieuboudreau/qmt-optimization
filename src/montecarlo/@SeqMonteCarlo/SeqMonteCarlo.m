classdef (Abstract = true) SeqMonteCarlo < handle
    %SEQMONTECARLO Abstract class to handle Monte Carlo simulations
    %

    properties (Access = protected)
        protocolObj
        tissueParamsObj
    end

    methods (Access = public)
        % Constructor
        % Must be explicitely called in all subclass constructors prior to
        % handling the object.
        % e.g. obj = obj@SeqJacobian(SeqProtocolInstance, TissueParamsInstance);
        
        function obj = SeqMonteCarlo(SeqProtocolInstance, TissueParamsInstance)
            assert(isa(SeqProtocolInstance, 'SeqProtocol'), 'SeqJacobian:missingClass', 'First input argument to SeqJacobian subclasses must be an object that has a parent class of type ''SeqProtocol''')
            assert(isa(TissueParamsInstance, 'TissueParams'), 'TissueParams:missingClass', 'Second input argument to SeqJacobian subclasses must be an object that has a parent class of type ''TissueParams''')
        end

    end

    methods (Access = protected)

    end

    methods (Static, Access = public)

    end

end

