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

        jacobianStruct = struct('jacobianMatrix',[]);

        derivMapDirection = 'forward';
    end

    properties (Access = private)
       deltaPerc = 10^(-2); % Percentage difference for derivatives calculations
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

        % Get methods
        jacobianMatrix = getJacobian(obj)
        jacobianMatrix = getJacobianStruct(obj)
        remainingRows = getRemainingRows(obj)
        protPoint = getProtocolPoint(obj, rowIndex)

        % Generate methods
        tissueJacStruct = genTissueJacStruct(obj)
        deltaProtPoint = genDeltaProtPoint(obj, protPoint)
        deltaTissueParams = genDeltaTissueParams(obj, tissueJacStruct, tissueParams, computeOpts, paramIndex)

        % Methods for Jacobian computation
        computeOpts = compute(obj, computeOpts)
        signalValues = simulateSignal(obj, curProtPoint, tissueParams)
    end

    methods (Static, Access = public)
        % Mapping methods
        signVal = derivMap(mapType);
    end

end

