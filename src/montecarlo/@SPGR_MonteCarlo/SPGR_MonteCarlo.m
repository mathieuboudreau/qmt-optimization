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
    end

    properties (Access = public)
    end
    
    methods (Access = public)
        % Constructor
        function obj = SPGR_MonteCarlo(SPGR_Protocol_Obj, SPGR_Tissue_Obj)
            obj = obj@SeqMonteCarlo(SPGR_Protocol_Obj, SPGR_Tissue_Obj);

            assert(isa(SPGR_Protocol_Obj, 'SPGR_Protocol'))
            assert(isa(SPGR_Tissue_Obj, 'SPGR_Tissue'))

            obj.protocolObj = SPGR_Protocol_Obj;
            obj.tissueParamsObj = SPGR_Tissue_Obj;
        end
    end
    
    methods (Access = protected)
    end

    methods (Static, Access = public)
    end

end

