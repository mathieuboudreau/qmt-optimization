function [] = remove(obj, indices)
%REMOVE Remove sets of angle/offset acquisition points from the protocol.
%   "indices" must be 1D and of same length as both protocol.Angles and
%   protocol.Offsets.
    
    if(~islogical(indices))
       try
          indices = logical(indices); 
       catch ME
           error(ME.identifier, ME.message)
       end
    end

    if( length(indices) ~= length(obj.protocol.Angles) )

        error('SPGR_Protocol:inequalLength', 'indices must be same length as obj.protocol.Angles')
    
    elseif( length(indices) ~= length(obj.protocol.Offsets) )

        error('SPGR_Protocol:inequalLength', 'indices must be same length as obj.protocol.Offsets')

    else
        obj.protocol.Angles(indices) = [];
        obj.protocol.Offsets(indices) = [];
    end

end
