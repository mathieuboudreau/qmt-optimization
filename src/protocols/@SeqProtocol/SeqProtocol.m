classdef (Abstract = true) SeqProtocol < handle
    %SEQPROTOCOL Abstract class for MRI pulse sequence protocols
    %
    %   Save and load methods deal strictly at importing/exporting the
    %   protocol property from/to external files.
    %
    %   getProtocol should give the objects protocol details/variables in a
    %   human redable format for the user.

    properties (Abstract = true, Access = protected)
        id
        protocol
    end

    methods (Abstract = true, Access = public)
        save(obj, fileName)
        load(obj, fileName)

        setID(obj, idName)
        getID(obj)
        getProtocol(obj)
    end

end

