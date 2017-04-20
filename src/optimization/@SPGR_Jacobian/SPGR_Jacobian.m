classdef SPGR_Jacobian < SeqJacobian
    %SPGR_JACOBIAN Calculate and store Jacobian for an SPGR qMT sequence.
    %
    %   --Methods--
    %   compute(computeOpts): Compute Jacobian rows.
    %       computeOpts: Struct with three properties - 'mode',
    %       'paramsOfInterest', and 'linesBuffer'.
    %           
    %           computeOpts.mode: String. 'New', 'Resume', or 'Completed'.
    %
    %           computeOpts.paramsOfInterest: Cell array of strings. Can be
    %           any key values of SPGR_Tissue.fitParamsKeys and/or 
    %           SPGR_Protocol.fitProtKeys.
    %
    %           computeOpts.lineBuffer: Integer. Number of Jacobian rows to
    %           be calculated in the next call of compute.
    %
    %       *returns*: computeOpts with updated 'mode' property/status.
    %
    %   getJacobian(): Returns Jacobian matrix values calculated to date.
    %
    %   getJacobianStruct(): Returns Jacobian struct. Contains Jacobian
    %   along with additional properties that may be useful for some users.
    %


    properties (Access = protected)
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
    
    methods (Access = protected)
        % Get methods
        protPoint = getProtocolPoint(obj, rowIndex)

        % Generate methods
        deltaProtPoint = genDeltaProtPoint(obj, protPoint, paramIndex)
        deltaTissueParams = genDeltaTissueParams(obj, tissueJacStruct, tissueParams, computeOpts, paramIndex)

        % Methods for Jacobian computation
        signalValues = simulateSignal(obj, curProtPoint, tissueParams)
    end

    methods (Static, Access = public)
    end

end

