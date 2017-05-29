function [] = resetRankedAcqPoints(obj)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    obj.rankedAcqPoints = zeros(size(obj.fitParamJacobian,1), 1);
end

