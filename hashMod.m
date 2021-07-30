%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title:        Hash Function Modulus
% Author:       Samir Habibi (sid1819364)
% Rev. Date:    30/04/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [index] = hashMod(key, tS)
%HASHMOD Perform hashing method: Modulus
% Takes key, returns index after performing modulus
% .. taking the remainder, where the  table size 
% .. defines the value for euclidean division

% Perform modulus, obtain index
index = mod(key, tS);

end % end function
