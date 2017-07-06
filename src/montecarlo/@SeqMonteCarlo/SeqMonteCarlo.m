classdef (Abstract = true) SeqMonteCarlo < handle
    %SEQMONTECARLO Abstract class to handle Monte Carlo simulations
    %

    properties (Access = protected)
        % Initialization arguments
        protocolObj
        tissueParamsObj
        fitOptsObj

        % Data generated through initialization
        noiselessSignal
        
        noisyDataset

        noiselessFittingData
        noisyFittingData
        
        % Data generated through fitting
        fitResults
    end

    methods (Access = public)
        % Constructor
        % Must be explicitely called in all subclass constructors prior to
        % handling the object.
        % e.g. obj = obj@SeqJacobian(SeqProtocolInstance, TissueParamsInstance);
        
        function obj = SeqMonteCarlo(SeqProtocolInstance, TissueParamsInstance, SeqFitOptsInstance)
            assert(isa(SeqProtocolInstance, 'SeqProtocol'), 'SeqJacobian:missingClass', 'First input argument to SeqMonteCarlo subclasses must be an object that has a parent class of type ''SeqProtocol''')
            assert(isa(TissueParamsInstance, 'TissueParams'), 'TissueParams:missingClass', 'Second input argument to SeqMonteCarlo subclasses must be an object that has a parent class of type ''TissueParams''')
            assert(isa(SeqFitOptsInstance, 'SeqFitOpts'), 'SeqFitOpts:missingClass', 'Third input argument to SeqMonteCarlo subclasses must be an object that has a parent class of type ''SeqFitOpts''')

            obj.protocolObj = SeqProtocolInstance;
            obj.tissueParamsObj = TissueParamsInstance;
            obj.fitOptsObj = SeqFitOptsInstance;

            % Generate noiseless signal upon initialization.
            try
                obj.genSignal();
            catch
                error('SeqMonteCarlo:genSignal', 'Error generating noiseless signal during object initialization - abort.');
            end
        end
        
        % Generate noise dataset
        noisyDataset = genNoisyDataset(obj, snrLevel, numPoints)
        
        % Prep data for fitting
        data = prep(obj)

        % Fit data
        data = fit(obj)
        
        % Get methods
        noiselessSignal = getNoiselessSignal(obj);
        data = getFittingData(obj)
    end

    methods (Access = protected)
        % Generate noiseless signal using initialized tissue and protocol
        noiselessSignal = genSignal(obj)

        % Add noise to the noiselessSignal array
        noisySignal = addNoise(obj, snrLevel)
    end

    methods (Static, Access = public)

    end

end

