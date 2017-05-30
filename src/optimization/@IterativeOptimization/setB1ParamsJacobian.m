function setB1ParamsJacobian(obj)
%SETB1PARAMSJACOBIAN Set the b1ParamsJacobians from the Jacobian object for
%the b1Params cell strings specified in the opts.
   
    jacStruct = obj.jacobianObj.getJacobianStruct();
    
    for ii = 1:length(obj.opts.b1Params)
        jacColumnIndices(ii) = find(ismember(jacStruct.paramsKeys, obj.opts.b1Params(ii)));
    end
    
    obj.b1ParamsJacobian =  jacStruct.jacobianMatrix(:, jacColumnIndices);
end
