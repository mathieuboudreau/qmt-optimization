function deltaProtPoint = genDeltaProtPoint(obj, protPoint, paramIndex)
%GENDELTAPROTPOINT Summary of this function goes here

    switch obj.jacobianStruct.paramsKeys{paramIndex}
        case 'B1_IR'
            derivSign = obj.derivMap(obj.derivMapDirection);

            deltaProtPoint = protPoint;
            deltaProtPoint.Alpha = protPoint.Alpha * (1 + derivSign * (obj.deltaPerc/100));  
            deltaProtPoint.Angles = protPoint.Angles * (1 + derivSign * (obj.deltaPerc/100));  
            
        otherwise
            deltaProtPoint = protPoint;
    end

end

