function totalNumberOfMeas = getNumberOfMeas(obj)
%GETNUMBEROFMEAS Returns the total number of measurements in a protocol.

	totalNumberOfMeas = length(obj.protocol.Offsets);
end