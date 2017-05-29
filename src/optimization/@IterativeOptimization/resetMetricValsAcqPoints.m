function [] = resetMetricValsAcqPoints(obj)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    obj.metricValsAcqPoints = nan(size(obj.fitParamJacobian,1), 1);
end

