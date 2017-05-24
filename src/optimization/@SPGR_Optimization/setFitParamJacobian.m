function setFitParamJacobian(obj)
%SETFITPARAMJACOBIAN Set the fitParamJacobian from the Jacobian object for
%the fitParams cell strings specified in the opts.
   
    jacStruct = obj.jacobianObj.getJacobianStruct();
    
    for ii = 1:length(obj.opts.fitParams)
        jacColumnIndices(ii) = find(ismember(jacStruct.paramsKeys, obj.opts.fitParams(ii)));
    end
    
    obj.fitParamJacobian =  jacStruct.jacobianMatrix(:, jacColumnIndices);
end
