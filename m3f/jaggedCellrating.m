function [jCells] = jaggedCellrating(ids, ratings, numEntries)
% JAGGEDCELL Jagged cell indexing of an array.
% @author: richard
%
% Usage:
%    [jCells] = jaggedCell(ids, numEntries)
%
% Inputs:
%    ids - array of integer ids
%    ratings - array of integer ratings
%    numEntries - Maximum id accounted for in ids
%
% Outputs:
%    jCells - Jagged cell array where the ith entry is an array of indices
%             corresponding to each rating of i in ids

% -----------------------------BEGIN CODE--------------------------------

fprintf('Running jaggedCell\n');

numExamples = length(ids);
% Count the number of occurrences of each id in ids
counts = accumarrayMex(ids, 1, [numEntries,1]);
% Initialize jagged cell array
jCells = cell(size(counts));
for r = 1:numEntries
    jCells{r} = zeros(1,counts(r), 'double');
    counts(r) = 1;
end
% Populate jagged cell array with indices of entries
% referencing each id in ids
ratings = double(ratings);
%ratings = min(ratings, 5);
%ratings = max(ratings, 1);

for e = 1:numExamples
    r = ids(e);
    % changed here @richard, if not all users are in the test data
%    if r > numEntries
%        continue;
%    end    
    jCells{r}(counts(r)) = ratings(e);
    counts(r) = counts(r) + 1; 
end

% -----------------------------END OF CODE-------------------------------
