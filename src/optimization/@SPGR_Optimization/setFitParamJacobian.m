function setFitParamJacobian(obj)
%SETFITPARAMJACOBIAN Set the fitParamJacobian from the Jacobian object for
%the fitParams cell strings specified in the opts.
   
    jacStruct = obj.jacobianObj.getJacobianStruct();
    
    jacColumnIndices = find(ismember(jacStruct.paramsKeys, obj.opts.fitParams));

    fitParamJacobian =  jacStruct.jacobianMatrix(:, jacColumnIndices);
end
