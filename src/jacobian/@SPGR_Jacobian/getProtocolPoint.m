function protPoint = getProtocolPoint(obj, rowIndex)
%GETPROTOCOLPOINT Get protocol for a single point within the full protocol.
    fullProt = obj.protocolObj.getProtocol;
    protPoint =  fullProt;
    protPoint.Angles = fullProt.Angles(rowIndex);
    protPoint.Offsets = fullProt.Offsets(rowIndex);
end
