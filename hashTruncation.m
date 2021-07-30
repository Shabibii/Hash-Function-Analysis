%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title:        Hash Function Truncation
% Author:       Samir Habibi (sid1819364)
% Rev. Date:    29/04/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [index] = hashTruncation(key, tS)
%HASHTRUNCATION Perform hashing method: Truncation
% Takes key, returns index after truncation
% .. length of trunc. range depends on table size
% .. no range required as input

% Convert key to type string
y = num2str(key);

% Take last x number of digits, where x depends on table size (parameter)
index = sscanf(y(end - ((numel(num2str(tS)))-2) :end), '%d');

end % end function