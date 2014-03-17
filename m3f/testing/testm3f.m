
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
test_external = false;
test_tib = false;
test_tif = true;

if test_external
%    path = {'llorma/100rank10Nmodels50', ...
%             'llorma/100rank20Nmodels50'   }; 
    path = {'sgd/100rank10', ...
             'sgd/100rank20'   }; 
    KU = 1;
    KM = 1;
    KUdist = '';
    KMdist = '';

    NumFacs = 2;
    Ngibbs = 2;
    Nburnin = 0;
    dirname = sprintf('llorma');
    whichdata = sprintf('movielens1M');                
    mkdir(dirname);
    err = upload_external(whichdata, [100], path, ...
                          NumFacs, KU, KM, KUdist, KMdist);
                      
%     path = {'llorma/101rank20Nmodels50', ...
%             'llorma/101rank10Nmodels50'}; 
     path = {'sgd/101rank10', ...
             'sgd/101rank20'   }; 

    err = upload_external(whichdata, [101], path, ...
                          NumFacs, KU, KM, KUdist, KMdist);    
end

if test_tib      
       
        
KUdist = '';
Ngibbs = 500 ;
Nburnin = 400;
whichdata = sprintf('movielens1M');                
 for i = 1:2
    KU = i * 10;
    KM = i * 5;
    for j = 1:2
        NumFacs = 10 * j;
        for k = 1:2
            if (k == 1)
               distSeed = 301;
               KMdist = sprintf('kmeansKMdist-dim%dals.txt', KM); 
            else
                distSeed = 300;
                KMdist = '';
            end
            
             dirname = sprintf('results/Prior%d-m3f_tib-KU%d-KM%d-NumFacs%d',...
                        distSeed, KU, KM, NumFacs);
             mkdir(dirname);
             mkdir(sprintf([dirname,'/models']));
            mkdir(sprintf([dirname,'/samples']));
            mkdir(sprintf([dirname,'/log']));
            err = m3f_tib_exper(dirname, whichdata, [100 101], 3, ...
                12345,  NumFacs, KU, KM , KUdist, KMdist, Ngibbs, Nburnin);
        end
    end
 end
 
 for i = 1:2
    KU = i * 5;
    KM = i * 5;
    for j = 1:2
        NumFacs = 10 * j;
        for k = 1:2
            if (k == 1)
               distSeed = 301;
               KMdist = sprintf('kmeansKMdist-dim%dals.txt', KM); 
            else
                distSeed = 300;
                KMdist = '';
            end
            
             dirname = sprintf('results/Prior%d-m3f_tib-KU%d-KM%d-NumFacs%d',...
                        distSeed, KU, KM, NumFacs);
             mkdir(dirname);
             mkdir(sprintf([dirname,'/models']));
            mkdir(sprintf([dirname,'/samples']));
            mkdir(sprintf([dirname,'/log']));
            err = m3f_tib_exper(dirname, whichdata, [100 101], 3, ...
                12345,  NumFacs, KU, KM , KUdist, KMdist, Ngibbs, Nburnin);
        end
    end
 end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                
%     KU = 5;
%     KM = 5;
%         dirname = sprintf('results/Prior%d-m3f_tib-KU%d-KM%d-NumFacs%d',...
%                         distSeed, KU, KM, NumFacs)
%         mkdir(dirname);
%         mkdir(sprintf([dirname,'/models']));
%         mkdir(sprintf([dirname,'/samples']));
%         mkdir(sprintf([dirname,'/log']));
%     err = m3f_tib_exper(dirname, whichdata, [100 101], 3, ...
%          12345,  NumFacs, KU, KM , KUdist, KMdist, Ngibbs, Nburnin);
   %%
  
end
 

if test_tif
NumTopicFacs = 2;            
KUdist = '';
Ngibbs = 500 ;
Nburnin = 400;
whichdata = sprintf('movielens1M');                
 for i = 2:2
    KU = i * 10;
    KM = i * 5;
    for j = 1:2
        NumFacs = 10 * j;
        for k = 1:2
            if (k == 1)
               distSeed = 301;
               KMdist = sprintf('kmeansKMdist-dim%dals.txt', KM); 
            else
                distSeed = 300;
                KMdist = '';
            end
            
             dirname = sprintf('results/Prior%d-m3f_tif-KU%d-KM%d-NumFacs%d',...
                        distSeed, KU, KM, NumFacs);
             mkdir(dirname);
             mkdir(sprintf([dirname,'/models']));
            mkdir(sprintf([dirname,'/samples']));
            mkdir(sprintf([dirname,'/log']));
                err = m3f_tif_exper(dirname, whichdata, [100 101], 3, ...
        12345,  NumFacs, KU, KM , KUdist, KMdist, NumTopicFacs, Ngibbs, Nburnin);

        end
    end
 end
 
 for i = 1:1
    KU = i * 5;
    KM = i * 5;
    for j = 1:2
        NumFacs = 10 * j;
        for k = 1:2
            if (k == 1)
               distSeed = 301;
               KMdist = sprintf('kmeansKMdist-dim%dals.txt', KM); 
            else
                distSeed = 300;
                KMdist = '';
            end
            
             dirname = sprintf('results/Prior%d-m3f_tif-KU%d-KM%d-NumFacs%d',...
                        distSeed, KU, KM, NumFacs);
             mkdir(dirname);
             mkdir(sprintf([dirname,'/models']));
            mkdir(sprintf([dirname,'/samples']));
            mkdir(sprintf([dirname,'/log']));
                err = m3f_tif_exper(dirname, whichdata, [100 101], 3, ...
        12345,  NumFacs, KU, KM , KUdist, KMdist, NumTopicFacs, Ngibbs, Nburnin);

        end
    end
 end
end
% %% scripts to get the table
% if test_tib
%     KU = 2;
%     KM = 1;
%     NumFacs = 10;
%     Ngibbs = 500;
%     Nburnin = 400;
% %    dirname = sprintf('m3f_tib-KU%d-KM%d-NumFacs%d',...
% %                        KU, KM, NumFacs);
%     dirname = sprintf('m3f_tib-meta500');
%     whichdata = sprintf('movielens100k');                
%     mkdir(dirname);
%     mkdir(sprintf([dirname,'/models']));
%     mkdir(sprintf([dirname,'/samples']));
%     mkdir(sprintf([dirname,'/log']));
%     %   m3f_tib_exper(experName, dataName, splitNums, initMode, ...
%     %                             seed, numFacs, KU, KM, ...
%     %                             Ngibbs, Nburnin)
%     
% %    err = m3f_tib_exper(dirname, whichdata, [100 101], 1, ...
% %        12345,  NumFacs, KU, KM , Ngibbs, Nburnin);
%     for i = 1:4
%         NumFacs = 10 * i;
%         err = m3f_tib_exper(dirname, whichdata, [100 101], 3, ...
%        12345,  NumFacs, KU, KM , Ngibbs, Nburnin);
%     end
%     %------------------%
%     KU = 5;
%     KM = 5;
%     for i = 1:4
%         NumFacs = 10 * i;
%         err = m3f_tib_exper(dirname, whichdata, [100 101], 3, ...
%        12345,  NumFacs, KU, KM , Ngibbs, Nburnin);
%     end
%     %--------------------%
%     KU = 10;
%     KM = 10;
%     for i = 1:4
%         NumFacs = 10 * i;
%         err = m3f_tib_exper(dirname, whichdata, [100 101], 3, ...
%        12345,  NumFacs, KU, KM , Ngibbs, Nburnin);
%     end
%     %--------------------%
%     KU = 20;
%     KM = 10;
%     for i = 1:4
%         NumFacs = 10 * i;
%         err = m3f_tib_exper(dirname, whichdata, [100 101], 3, ...
%        12345,  NumFacs, KU, KM , Ngibbs, Nburnin);
%     end
%     
%     
%  end
% 
% if test_tif
%     KU = 2;
%     KM = 1;
%     NumFacs = 10;
%     NumTopicFacs = 2;
%     Ngibbs = 500;
%     Nburnin = 400;
%    % dirname = sprintf('m3f_tif-KU%d-KM%d-NumFacs%d-NumTopicFacs%d',...
%     %                    KU, KM, NumFacs, NumTopicFacs);
%     dirname = sprintf('m3f_tif-meta500');
%     whichdata = sprintf('movielens100k');                
%     mkdir(dirname);
%     mkdir(sprintf([dirname,'/models']));
%     mkdir(sprintf([dirname,'/samples']));
%     mkdir(sprintf([dirname,'/log']));
%     %   m3f_tif_exper(experName, dataName, splitNums, initMode, ...
%     %                             seed, numFacs, KU, KM, numTopicFacs,...
%     %                             Ngibbs, Nburnin)
% %    err = m3f_tif_exper(dirname, whichdata, [100 101], 3, ...
% %       12345,  NumFacs, KU, KM, NumTopicFacs, Ngibbs, Nburnin);
%     for i = 1:4
%         NumFacs = 10 * i;
%         err = m3f_tif_exper(dirname, whichdata, [100 101], 3, ...
%        12345,  NumFacs, KU, KM ,NumTopicFacs,  Ngibbs, Nburnin);
%     end
%     %------------------%
%     KU = 5;
%     KM = 5;
%     for i = 1:4
%         NumFacs = 10 * i;
%         err = m3f_tif_exper(dirname, whichdata, [100 101], 3, ...
%        12345,  NumFacs, KU, KM ,NumTopicFacs,  Ngibbs, Nburnin);
%     end
%     %------------------%
%     KU = 10;
%     KM = 10;
%     for i = 1:4
%         NumFacs = 10 * i;
%         err = m3f_tif_exper(dirname, whichdata, [100 101], 3, ...
%        12345,  NumFacs, KU, KM , NumTopicFacs, Ngibbs, Nburnin);
%     end
%     %--------------------%
%     KU = 20;
%     KM = 10;
%     for i = 1:4
%         NumFacs = 10 * i;
%         err = m3f_tif_exper(dirname, whichdata, [100 101], 3, ...
%        12345,  NumFacs, KU, KM , NumTopicFacs, Ngibbs, Nburnin);
%     end
%     %--------------------%
%    
%     
% end
%% 

% -----------------------------END OF CODE-------------------------------
