function [] = resetReguTermValsAcqPoints(obj)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    obj.reguTermValsAcqPoints = nan(size(obj.fitParamJacobian,1), 1);
end

