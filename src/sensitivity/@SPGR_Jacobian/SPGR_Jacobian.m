classdef SPGR_Jacobian < SeqJacobian
    %SEQJacobian Abstract class to calculate and store Jacobian for an MRI
    %pulse sequence
    %
    %   Save and load methods deal strictly at importing/exporting the
    %   protocol property from/to external files.
    %
    %   getProtocol should give the objects protocol details/variables in a
    %   human redable format for the user.

    properties (Access = protected)
        protocolObj
        tissueParamsObj
    end

    methods (Access = public)
        % Constructor
        function obj = SPGR_Jacobian(SPGR_Protocol_Obj, SPGR_Tissue_Obj)
            obj = obj@SeqJacobian(SPGR_Protocol_Obj, SPGR_Tissue_Obj);
            
            assert(isa(SPGR_Protocol_Obj, 'SPGR_Protocol'))
            assert(isa(SPGR_Tissue_Obj, 'SPGR_Tissue'))
            
            obj.protocolObj = SPGR_Protocol_Obj;
            obj.tissueParamsObj = SPGR_Tissue_Obj;

        end
    end
    
    methods (Access = public)

    end

end

