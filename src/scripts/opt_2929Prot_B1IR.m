clear all
load('/Users/mathieuboudreau/Work/Projects/qMT_B1_Optimization_Paper_Analysis/processing/stage_2/part_1/processed_jacobians/2929point_protocol.mat')
opts.fitParams = {'F', 'kf', 'T2f', 'T2r'}
A=IterativeOptimization(jacobianObj, opts)
A.computeSingle

rankedAcqPoints = A.getRankedAcqPoints();

numPoints = length(rankedAcqPoints);

jacStruct = jacobianObj.getJacobianStruct();

for ii = 1:length(opts.fitParams)
    jacColumnIndices(ii) = find(ismember(jacStruct.paramsKeys, opts.fitParams(ii)));
end

fitParamJacobian =  jacStruct.jacobianMatrix(:, jacColumnIndices);

b1Jacobian = jacStruct.jacobianMatrix(:,end-1);

b1ParamError = zeros(numPoints,4);

for ii=numPoints:-1:1
    
    tmpParamJacMat = fitParamJacobian(rankedAcqPoints<=ii,:);
    tmpB1JacMat = b1Jacobian(rankedAcqPoints<=ii);

    
    b1ParamError(ii, :) = SeqOptimization.minimizeParamErrorBecauseOfMeasError(tmpParamJacMat, tmpB1JacMat, 0.05)'./jacStruct.paramsVals([1 2 5 4]).*100;

end

figure(), plot(b1ParamError(4:end,1))
figure(), plot(b1ParamError(4:end,2))
figure(), plot(b1ParamError(4:end,3))
figure(), plot(b1ParamError(4:end,4))
