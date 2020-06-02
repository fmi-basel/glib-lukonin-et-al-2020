function [indices] = vector_to_indices(B1,th1)

% Created on 03-Jan-2017 by Dr. Saadia Iftikhar, saadia.iftikhar@fmi.ch
% ---------------------------------------------------------------------

D1 = diff([1 B1 1]);
startIndex = find(D1 < 0);
endIndex = find(D1 > 0)-1;
duration = endIndex-startIndex+1;

stringIndex = (duration >= th1);
startIndex = startIndex(stringIndex);
endIndex = endIndex(stringIndex);

indices = zeros(1,max(endIndex)+1);
indices(startIndex) = 1;
indices(endIndex+1) = indices(endIndex+1)-1;
indices = find(cumsum(indices));

end

