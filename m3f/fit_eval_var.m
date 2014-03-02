function [ana] = fit_eval_var(data, testData, opts)
%
% Function to evaluate fitting results by individual
% Input: 
%       data
%       testdata
%       trainPreds
%       testPreds
%
% Output:
%       ana - analysis
%             ana.rmseByUser
%             ana.rmseByItem
%             ana.countByUser            
%             ana.countByItem
%             ana.varByUser
%             ana.varByItem
%       

fprintf('Running fit_eval_val\n');

trainrmseByUser = zeros(data.numUsers, 1);
trainrmseByItem = zeros(data.numItems, 1);
testrmseByUser = zeros(data.numUsers, 1);
testrmseByItem = zeros(data.numItems, 1);

[temp, countByUser] = cellfun(@size, data.exampsByUser);
[temp, countByItem] = cellfun(@size, data.exampsByItem);
varByUser = cellfun(@var, data.ratingsByUser);
varByItem = cellfun(@var, data.ratingsByItem);

for i = 1 : data.numUsers
    trainrmseByUser(i) = evalPreds(data.ratingsByUser{i}, data.fitByUser{i}, 'rmse');
    testrmseByUser(i) = evalPreds(testData.ratingsByUser{i}, testData.fitByUser{i}, 'rmse');
end

for i = 1 : data.numItems
    trainrmseByItem(i) = evalPreds(data.ratingsByItem{i}, data.fitByItem{i}, 'rmse');
    testrmseByItem(i) = evalPreds(testData.ratingsByItem{i}, testData.fitByItem{i}, 'rmse');
end

ana = struct('trainrmseByUser', trainrmseByUser, 'trainrmseByItem', trainrmseByItem, ...
              'testrmseByUser', testrmseByUser, 'testrmseByItem', testrmseByItem, ...
              'countByUser', countByUser, 'countByItem', countByItem, ... 
               'varByUser', varByUser, 'varByItem', varByItem);

itemmat = dataset({testrmseByItem, 'testRMSE'}, ... 
                   {trainrmseByItem, 'trainRMSE'}, ...
                   {varByItem, 'trainVariance'}, ...
                   {countByItem, 'count'});  
               
usermat = dataset({testrmseByUser, 'testRMSE'}, ... 
                   {trainrmseByUser, 'trainRMSE'}, ...
                   {varByUser, 'trainVariance'}, ...
                   {countByUser, 'count'});   
               
export(itemmat, 'file', opts.itemoutput);
export(usermat, 'file', opts.useroutput);
