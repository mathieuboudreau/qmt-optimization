function jacobianMatrix = getJacobian(obj)
%GETJACOBIAN Returns the Jacobian which was previously fully calculated for
%the object's initialized protocol and tissue.

   jacobianMatrix = obj.jacobianStruct.jacobianMatrix; 
end
