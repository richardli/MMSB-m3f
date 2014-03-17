function [err] = upload_external( dataName, split, path, numFacs, KU, KM, KUdist, KMdist)
[data, testData] = loadDyadicData(dataName, split, false);

 model = m3f_tib_initModel(data.numUsers, data.numItems, ...
                               numFacs, KU, KM,KUdist, KMdist);
%% Extract size information from model
numUsers = model.numUsers;
numItems = model.numItems;
%% Store example ids by user and by item
if ~isfield(data,'exampsByUser') || isempty(data.exampsByUser)
    data.exampsByUser = jaggedCell(data.users, numUsers);
end
if ~isfield(data,'exampsByItem') || isempty(data.exampsByItem)
    data.exampsByItem = jaggedCell(data.items, numItems);
end

[temp, countByItem] = cellfun(@size, data.exampsByItem);
varByItem = cellfun(@var, data.ratingsByItem);


for i = 1:length(path)
    p = path{i};
    opts.itemoutput = sprintf([p,'ItermMatrix_%s_split%d_model%s_init%d.log'], ...
                             dataName, split, 'external');
    testPreds = dlmread(p);

    %% after looping, update predicted ratings to jagged cell
    testData.fitByUser = jaggedCellrating(testData.users, testPreds, data.numUsers);
    testData.fitByItem = jaggedCellrating(testData.items, testPreds, data.numItems);

    %%Analyze by user / item
    testrmseByUser = zeros(data.numUsers, 1);
    testrmseByItem = zeros(data.numItems, 1);
    
    for i = 1 : data.numItems
        testrmseByItem(i) = evalPreds(testData.ratingsByItem{i}, testData.fitByItem{i}, 'rmse');
    end
    itemmat = dataset({testrmseByItem, 'testRMSE'}, ... 
                       {varByItem, 'trainVariance'}, ...
                       {countByItem, 'count'});  
    export(itemmat, 'file', opts.itemoutput);
end
err = 0;               

% -----------------------------END OF CODE-------------------------------
