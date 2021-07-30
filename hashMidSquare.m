%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title:        Hash Functions Test Harness
% Author:       Samir Habibi (sid1819364)
% Rev. Date:    29/04/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [index] = hashMidSquare(key, tS)
%HASHMIDSQUARE Perform hashing method: Mid Square
% Takes key, returns index after performing Mid Square
% .. get square of 'key', and take x number of digits
% .. from approximately middle of key square value
% .. range of x depends on table size

% Set key square to string
keySq = num2str(key^2);

% Get length of key square
s = numel(keySq);

% Get middle of length
firstDigit = floor(s/2);

% Define range based on table size
lastDigit = firstDigit+numel(num2str(tS))-2;

% Scan string numbers in range for index
index = sscanf(keySq(firstDigit:lastDigit), '%d');

end % end function
