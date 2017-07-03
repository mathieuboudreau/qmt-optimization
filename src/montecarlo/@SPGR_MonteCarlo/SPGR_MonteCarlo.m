classdef SPGR_MonteCarlo < SeqMonteCarlo
    %SPGR_MONTECARLO Evaluate and store Monte Carlo simulations for an SPGR 
    %qMT sequence.
    %
    %   --Initialization--
    %   SPGR_MonteCarlo(SPGR_Protocol, SPGR_Tissue)
    %
    %   --Methods--
    %

    properties (Access = protected)
        noisyDataset
    end

    properties (Access = public)
    end
    
    methods (Access = public)
        % Constructor
        function obj = SPGR_MonteCarlo(SPGR_Protocol_Obj, SPGR_Tissue_Obj)
            obj = obj@SeqMonteCarlo(SPGR_Protocol_Obj, SPGR_Tissue_Obj);

            assert(isa(SPGR_Protocol_Obj, 'SPGR_Protocol'))
            assert(isa(SPGR_Tissue_Obj, 'SPGR_Tissue'))
        end
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

