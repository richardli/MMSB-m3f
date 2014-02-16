
% -----------------------------------------------------------------------     
%
% Last revision: 9-July-2010
%
% Authors: Lester Mackey and David Weiss
% License: MIT License
%
% Copyright (c) 2010 Lester Mackey & David Weiss
%
% Permission is hereby granted, free of charge, to any person obtaining
% a copy of this software and associated documentation files (the
% "Software"), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to
% permit persons to whom the Software is furnished to do so, subject to
% the following conditions:
% 
% The above copyright notice and this permission notice shall be
% included in all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
% NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
% LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
% OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
% WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%
% -----------------------------------------------------------------------

% -----------------------------BEGIN CODE--------------------------------

test_tib = false;
test_tif = true;

if test_tib
    mkdir('testm3f_tib');
    mkdir('testm3f_tib/models');
    mkdir('testm3f_tib/samples');
    mkdir('testm3f_tib/log');
    
    err = m3f_tib_exper('testm3f_tib', 'movielens100k', [1 2 3], 3, ...
        12345, 10, 2, 2);
end

if test_tif
    KU = 2;
    KM = 2;
    NumFacs = 10;
    NumTopicFacs = 10;
    dirname = sprintf('m3f_tif-KU%d-KM%d-NumFacs%d-NumTopicFacs%d',...
                        KU, KM, NumFacs, NumTopicFacs);
    mkdir(dirname);
    mkdir(sprintf([dirname,'/models']));
    mkdir(sprintf([dirname,'/samples']));
    mkdir(sprintf([dirname,'/log']));
    %   m3f_tif_exper(experName, dataName, splitNums, initMode, ...
    %                             seed, numFacs, KU, KM, numTopicFacs)
    err = m3f_tif_exper(dirname, 'movielens100k', [1 2 3 4 5], 2, ...
       12345,  NumFacs, KU, KM, NumTopicFacs);
end
%% 

% -----------------------------END OF CODE-------------------------------
