function [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% trainClassifier(trainingData)
%  returns a trained classifier and its accuracy.
%  This code recreates the classification model trained in
%  Classification Learner app.
%
%   Input:
%       trainingData: the training data of same data type as imported
%        in the app (table or matrix).
%
%   Output:
%       trainedClassifier: a struct containing the trained classifier.
%        The struct contains various fields with information about the
%        trained classifier.
%
%       trainedClassifier.predictFcn: a function to make predictions
%        on new data. It takes an input of the same form as this training
%        code (table or matrix) and returns predictions for the response.
%        If you supply a matrix, include only the predictors columns (or
%        rows).
%
%       validationAccuracy: a double containing the accuracy in
%        percent. In the app, the History list displays this
%        overall accuracy score for each model.
%
%  Use the code to train the model with new data.
%  To retrain your classifier, call the function from the command line
%  with your original data or new data as the input argument trainingData.
%
%  For example, to retrain a classifier trained with the original data set
%  T, enter:
%    [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
%  To make predictions with the returned 'trainedClassifier' on new data T,
%  use
%    yfit = trainedClassifier.predictFcn(T)
%
%  To automate training the same classifier with new data, or to learn how
%  to programmatically train classifiers, examine the generated code.

% Auto-generated by MATLAB on 26-Nov-2016 14:17:31


% Extract predictors and response
% This code processes the data into the right shape for training the
% classifier.
inputTable = trainingData;
predictorNames = {'fruitsdata1', 'fruitsdata2', 'fruitsdata3', 'fruitsdata4', 'fruitsdata5', 'fruitsdata6', 'fruitsdata7', 'fruitsdata8', 'fruitsdata9', 'fruitsdata10', 'fruitsdata11', 'fruitsdata12', 'fruitsdata13', 'fruitsdata14', 'fruitsdata15', 'fruitsdata16', 'fruitsdata17', 'fruitsdata18', 'fruitsdata19', 'fruitsdata20', 'fruitsdata21', 'fruitsdata22', 'fruitsdata23', 'fruitsdata24', 'fruitsdata25', 'fruitsdata26', 'fruitsdata27', 'fruitsdata28', 'fruitsdata29', 'fruitsdata30', 'fruitsdata31', 'fruitsdata32', 'fruitsdata33', 'fruitsdata34', 'fruitsdata35', 'fruitsdata36', 'fruitsdata37', 'fruitsdata38', 'fruitsdata39', 'fruitsdata40', 'fruitsdata41', 'fruitsdata42', 'fruitsdata43', 'fruitsdata44', 'fruitsdata45', 'fruitsdata46', 'fruitsdata47', 'fruitsdata48', 'fruitsdata49', 'fruitsdata50', 'fruitsdata51', 'fruitsdata52', 'fruitsdata53', 'fruitsdata54', 'fruitsdata55', 'fruitsdata56', 'fruitsdata57', 'fruitsdata58', 'fruitsdata59', 'fruitsdata60', 'fruitsdata61', 'fruitsdata62', 'fruitsdata63', 'fruitsdata64', 'fruitsdata65', 'fruitsdata66', 'fruitsdata67', 'fruitsdata68', 'fruitsdata69', 'fruitsdata70', 'fruitsdata71', 'fruitsdata72', 'fruitsdata73', 'fruitsdata74', 'fruitsdata75', 'fruitsdata76', 'fruitsdata77', 'fruitsdata78', 'fruitsdata79', 'fruitsdata80', 'fruitsdata81', 'fruitsdata82', 'fruitsdata83', 'fruitsdata84', 'fruitsdata85', 'fruitsdata86', 'fruitsdata87', 'fruitsdata88', 'fruitsdata89', 'fruitsdata90', 'fruitsdata91', 'fruitsdata92', 'fruitsdata93', 'fruitsdata94', 'fruitsdata95', 'fruitsdata96', 'fruitsdata97', 'fruitsdata98', 'fruitsdata99', 'fruitsdata100', 'fruitsdata101', 'fruitsdata102', 'fruitsdata103', 'fruitsdata104', 'fruitsdata105', 'fruitsdata106', 'fruitsdata107', 'fruitsdata108', 'fruitsdata109', 'fruitsdata110', 'fruitsdata111', 'fruitsdata112', 'fruitsdata113', 'fruitsdata114', 'fruitsdata115', 'fruitsdata116', 'fruitsdata117', 'fruitsdata118', 'fruitsdata119', 'fruitsdata120', 'fruitsdata121', 'fruitsdata122', 'fruitsdata123', 'fruitsdata124', 'fruitsdata125', 'fruitsdata126', 'fruitsdata127', 'fruitsdata128', 'fruitsdata129', 'fruitsdata130', 'fruitsdata131', 'fruitsdata132', 'fruitsdata133', 'fruitsdata134', 'fruitsdata135', 'fruitsdata136', 'fruitsdata137', 'fruitsdata138', 'fruitsdata139', 'fruitsdata140', 'fruitsdata141', 'fruitsdata142', 'fruitsdata143', 'fruitsdata144', 'fruitsdata145', 'fruitsdata146', 'fruitsdata147', 'fruitsdata148', 'fruitsdata149', 'fruitsdata150', 'fruitsdata151', 'fruitsdata152', 'fruitsdata153', 'fruitsdata154', 'fruitsdata155', 'fruitsdata156', 'fruitsdata157', 'fruitsdata158', 'fruitsdata159', 'fruitsdata160', 'fruitsdata161', 'fruitsdata162', 'fruitsdata163', 'fruitsdata164', 'fruitsdata165', 'fruitsdata166', 'fruitsdata167', 'fruitsdata168', 'fruitsdata169', 'fruitsdata170', 'fruitsdata171', 'fruitsdata172', 'fruitsdata173', 'fruitsdata174', 'fruitsdata175', 'fruitsdata176', 'fruitsdata177', 'fruitsdata178', 'fruitsdata179', 'fruitsdata180', 'fruitsdata181', 'fruitsdata182', 'fruitsdata183', 'fruitsdata184', 'fruitsdata185', 'fruitsdata186', 'fruitsdata187', 'fruitsdata188', 'fruitsdata189', 'fruitsdata190', 'fruitsdata191', 'fruitsdata192', 'fruitsdata193', 'fruitsdata194', 'fruitsdata195', 'fruitsdata196', 'fruitsdata197', 'fruitsdata198', 'fruitsdata199', 'fruitsdata200', 'fruitsdata201', 'fruitsdata202', 'fruitsdata203', 'fruitsdata204', 'fruitsdata205', 'fruitsdata206', 'fruitsdata207', 'fruitsdata208', 'fruitsdata209', 'fruitsdata210', 'fruitsdata211', 'fruitsdata212', 'fruitsdata213', 'fruitsdata214', 'fruitsdata215', 'fruitsdata216', 'fruitsdata217', 'fruitsdata218', 'fruitsdata219', 'fruitsdata220', 'fruitsdata221', 'fruitsdata222', 'fruitsdata223', 'fruitsdata224', 'fruitsdata225', 'fruitsdata226', 'fruitsdata227', 'fruitsdata228', 'fruitsdata229', 'fruitsdata230', 'fruitsdata231', 'fruitsdata232', 'fruitsdata233', 'fruitsdata234', 'fruitsdata235', 'fruitsdata236', 'fruitsdata237', 'fruitsdata238', 'fruitsdata239', 'fruitsdata240', 'fruitsdata241', 'fruitsdata242', 'fruitsdata243', 'fruitsdata244', 'fruitsdata245', 'fruitsdata246', 'fruitsdata247', 'fruitsdata248', 'fruitsdata249', 'fruitsdata250'};
predictors = inputTable(:, predictorNames);
response = inputTable.fruitType;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
subspaceDimension = max(1, min(125, width(predictors) - 1));
classificationEnsemble = fitensemble(...
    predictors, ...
    response, ...
    'Subspace', ...
    30, ...
    'KNN', ...
    'Type', 'Classification', ...
    'NPredToSample', subspaceDimension, ...
    'ClassNames', categorical({'Opened_pomigrante'; 'green_apple'; 'green_orange'; 'mango'; 'multispectral_red_apple'; 'orange'; 'red_apple'}));

% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
ensemblePredictFcn = @(x) predict(classificationEnsemble, x);
trainedClassifier.predictFcn = @(x) ensemblePredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'fruitsdata1', 'fruitsdata2', 'fruitsdata3', 'fruitsdata4', 'fruitsdata5', 'fruitsdata6', 'fruitsdata7', 'fruitsdata8', 'fruitsdata9', 'fruitsdata10', 'fruitsdata11', 'fruitsdata12', 'fruitsdata13', 'fruitsdata14', 'fruitsdata15', 'fruitsdata16', 'fruitsdata17', 'fruitsdata18', 'fruitsdata19', 'fruitsdata20', 'fruitsdata21', 'fruitsdata22', 'fruitsdata23', 'fruitsdata24', 'fruitsdata25', 'fruitsdata26', 'fruitsdata27', 'fruitsdata28', 'fruitsdata29', 'fruitsdata30', 'fruitsdata31', 'fruitsdata32', 'fruitsdata33', 'fruitsdata34', 'fruitsdata35', 'fruitsdata36', 'fruitsdata37', 'fruitsdata38', 'fruitsdata39', 'fruitsdata40', 'fruitsdata41', 'fruitsdata42', 'fruitsdata43', 'fruitsdata44', 'fruitsdata45', 'fruitsdata46', 'fruitsdata47', 'fruitsdata48', 'fruitsdata49', 'fruitsdata50', 'fruitsdata51', 'fruitsdata52', 'fruitsdata53', 'fruitsdata54', 'fruitsdata55', 'fruitsdata56', 'fruitsdata57', 'fruitsdata58', 'fruitsdata59', 'fruitsdata60', 'fruitsdata61', 'fruitsdata62', 'fruitsdata63', 'fruitsdata64', 'fruitsdata65', 'fruitsdata66', 'fruitsdata67', 'fruitsdata68', 'fruitsdata69', 'fruitsdata70', 'fruitsdata71', 'fruitsdata72', 'fruitsdata73', 'fruitsdata74', 'fruitsdata75', 'fruitsdata76', 'fruitsdata77', 'fruitsdata78', 'fruitsdata79', 'fruitsdata80', 'fruitsdata81', 'fruitsdata82', 'fruitsdata83', 'fruitsdata84', 'fruitsdata85', 'fruitsdata86', 'fruitsdata87', 'fruitsdata88', 'fruitsdata89', 'fruitsdata90', 'fruitsdata91', 'fruitsdata92', 'fruitsdata93', 'fruitsdata94', 'fruitsdata95', 'fruitsdata96', 'fruitsdata97', 'fruitsdata98', 'fruitsdata99', 'fruitsdata100', 'fruitsdata101', 'fruitsdata102', 'fruitsdata103', 'fruitsdata104', 'fruitsdata105', 'fruitsdata106', 'fruitsdata107', 'fruitsdata108', 'fruitsdata109', 'fruitsdata110', 'fruitsdata111', 'fruitsdata112', 'fruitsdata113', 'fruitsdata114', 'fruitsdata115', 'fruitsdata116', 'fruitsdata117', 'fruitsdata118', 'fruitsdata119', 'fruitsdata120', 'fruitsdata121', 'fruitsdata122', 'fruitsdata123', 'fruitsdata124', 'fruitsdata125', 'fruitsdata126', 'fruitsdata127', 'fruitsdata128', 'fruitsdata129', 'fruitsdata130', 'fruitsdata131', 'fruitsdata132', 'fruitsdata133', 'fruitsdata134', 'fruitsdata135', 'fruitsdata136', 'fruitsdata137', 'fruitsdata138', 'fruitsdata139', 'fruitsdata140', 'fruitsdata141', 'fruitsdata142', 'fruitsdata143', 'fruitsdata144', 'fruitsdata145', 'fruitsdata146', 'fruitsdata147', 'fruitsdata148', 'fruitsdata149', 'fruitsdata150', 'fruitsdata151', 'fruitsdata152', 'fruitsdata153', 'fruitsdata154', 'fruitsdata155', 'fruitsdata156', 'fruitsdata157', 'fruitsdata158', 'fruitsdata159', 'fruitsdata160', 'fruitsdata161', 'fruitsdata162', 'fruitsdata163', 'fruitsdata164', 'fruitsdata165', 'fruitsdata166', 'fruitsdata167', 'fruitsdata168', 'fruitsdata169', 'fruitsdata170', 'fruitsdata171', 'fruitsdata172', 'fruitsdata173', 'fruitsdata174', 'fruitsdata175', 'fruitsdata176', 'fruitsdata177', 'fruitsdata178', 'fruitsdata179', 'fruitsdata180', 'fruitsdata181', 'fruitsdata182', 'fruitsdata183', 'fruitsdata184', 'fruitsdata185', 'fruitsdata186', 'fruitsdata187', 'fruitsdata188', 'fruitsdata189', 'fruitsdata190', 'fruitsdata191', 'fruitsdata192', 'fruitsdata193', 'fruitsdata194', 'fruitsdata195', 'fruitsdata196', 'fruitsdata197', 'fruitsdata198', 'fruitsdata199', 'fruitsdata200', 'fruitsdata201', 'fruitsdata202', 'fruitsdata203', 'fruitsdata204', 'fruitsdata205', 'fruitsdata206', 'fruitsdata207', 'fruitsdata208', 'fruitsdata209', 'fruitsdata210', 'fruitsdata211', 'fruitsdata212', 'fruitsdata213', 'fruitsdata214', 'fruitsdata215', 'fruitsdata216', 'fruitsdata217', 'fruitsdata218', 'fruitsdata219', 'fruitsdata220', 'fruitsdata221', 'fruitsdata222', 'fruitsdata223', 'fruitsdata224', 'fruitsdata225', 'fruitsdata226', 'fruitsdata227', 'fruitsdata228', 'fruitsdata229', 'fruitsdata230', 'fruitsdata231', 'fruitsdata232', 'fruitsdata233', 'fruitsdata234', 'fruitsdata235', 'fruitsdata236', 'fruitsdata237', 'fruitsdata238', 'fruitsdata239', 'fruitsdata240', 'fruitsdata241', 'fruitsdata242', 'fruitsdata243', 'fruitsdata244', 'fruitsdata245', 'fruitsdata246', 'fruitsdata247', 'fruitsdata248', 'fruitsdata249', 'fruitsdata250'};
trainedClassifier.ClassificationEnsemble = classificationEnsemble;
trainedClassifier.About = 'This struct is a trained classifier exported from Classification Learner R2016a.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedClassifier''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% classifier.
inputTable = trainingData;
predictorNames = {'fruitsdata1', 'fruitsdata2', 'fruitsdata3', 'fruitsdata4', 'fruitsdata5', 'fruitsdata6', 'fruitsdata7', 'fruitsdata8', 'fruitsdata9', 'fruitsdata10', 'fruitsdata11', 'fruitsdata12', 'fruitsdata13', 'fruitsdata14', 'fruitsdata15', 'fruitsdata16', 'fruitsdata17', 'fruitsdata18', 'fruitsdata19', 'fruitsdata20', 'fruitsdata21', 'fruitsdata22', 'fruitsdata23', 'fruitsdata24', 'fruitsdata25', 'fruitsdata26', 'fruitsdata27', 'fruitsdata28', 'fruitsdata29', 'fruitsdata30', 'fruitsdata31', 'fruitsdata32', 'fruitsdata33', 'fruitsdata34', 'fruitsdata35', 'fruitsdata36', 'fruitsdata37', 'fruitsdata38', 'fruitsdata39', 'fruitsdata40', 'fruitsdata41', 'fruitsdata42', 'fruitsdata43', 'fruitsdata44', 'fruitsdata45', 'fruitsdata46', 'fruitsdata47', 'fruitsdata48', 'fruitsdata49', 'fruitsdata50', 'fruitsdata51', 'fruitsdata52', 'fruitsdata53', 'fruitsdata54', 'fruitsdata55', 'fruitsdata56', 'fruitsdata57', 'fruitsdata58', 'fruitsdata59', 'fruitsdata60', 'fruitsdata61', 'fruitsdata62', 'fruitsdata63', 'fruitsdata64', 'fruitsdata65', 'fruitsdata66', 'fruitsdata67', 'fruitsdata68', 'fruitsdata69', 'fruitsdata70', 'fruitsdata71', 'fruitsdata72', 'fruitsdata73', 'fruitsdata74', 'fruitsdata75', 'fruitsdata76', 'fruitsdata77', 'fruitsdata78', 'fruitsdata79', 'fruitsdata80', 'fruitsdata81', 'fruitsdata82', 'fruitsdata83', 'fruitsdata84', 'fruitsdata85', 'fruitsdata86', 'fruitsdata87', 'fruitsdata88', 'fruitsdata89', 'fruitsdata90', 'fruitsdata91', 'fruitsdata92', 'fruitsdata93', 'fruitsdata94', 'fruitsdata95', 'fruitsdata96', 'fruitsdata97', 'fruitsdata98', 'fruitsdata99', 'fruitsdata100', 'fruitsdata101', 'fruitsdata102', 'fruitsdata103', 'fruitsdata104', 'fruitsdata105', 'fruitsdata106', 'fruitsdata107', 'fruitsdata108', 'fruitsdata109', 'fruitsdata110', 'fruitsdata111', 'fruitsdata112', 'fruitsdata113', 'fruitsdata114', 'fruitsdata115', 'fruitsdata116', 'fruitsdata117', 'fruitsdata118', 'fruitsdata119', 'fruitsdata120', 'fruitsdata121', 'fruitsdata122', 'fruitsdata123', 'fruitsdata124', 'fruitsdata125', 'fruitsdata126', 'fruitsdata127', 'fruitsdata128', 'fruitsdata129', 'fruitsdata130', 'fruitsdata131', 'fruitsdata132', 'fruitsdata133', 'fruitsdata134', 'fruitsdata135', 'fruitsdata136', 'fruitsdata137', 'fruitsdata138', 'fruitsdata139', 'fruitsdata140', 'fruitsdata141', 'fruitsdata142', 'fruitsdata143', 'fruitsdata144', 'fruitsdata145', 'fruitsdata146', 'fruitsdata147', 'fruitsdata148', 'fruitsdata149', 'fruitsdata150', 'fruitsdata151', 'fruitsdata152', 'fruitsdata153', 'fruitsdata154', 'fruitsdata155', 'fruitsdata156', 'fruitsdata157', 'fruitsdata158', 'fruitsdata159', 'fruitsdata160', 'fruitsdata161', 'fruitsdata162', 'fruitsdata163', 'fruitsdata164', 'fruitsdata165', 'fruitsdata166', 'fruitsdata167', 'fruitsdata168', 'fruitsdata169', 'fruitsdata170', 'fruitsdata171', 'fruitsdata172', 'fruitsdata173', 'fruitsdata174', 'fruitsdata175', 'fruitsdata176', 'fruitsdata177', 'fruitsdata178', 'fruitsdata179', 'fruitsdata180', 'fruitsdata181', 'fruitsdata182', 'fruitsdata183', 'fruitsdata184', 'fruitsdata185', 'fruitsdata186', 'fruitsdata187', 'fruitsdata188', 'fruitsdata189', 'fruitsdata190', 'fruitsdata191', 'fruitsdata192', 'fruitsdata193', 'fruitsdata194', 'fruitsdata195', 'fruitsdata196', 'fruitsdata197', 'fruitsdata198', 'fruitsdata199', 'fruitsdata200', 'fruitsdata201', 'fruitsdata202', 'fruitsdata203', 'fruitsdata204', 'fruitsdata205', 'fruitsdata206', 'fruitsdata207', 'fruitsdata208', 'fruitsdata209', 'fruitsdata210', 'fruitsdata211', 'fruitsdata212', 'fruitsdata213', 'fruitsdata214', 'fruitsdata215', 'fruitsdata216', 'fruitsdata217', 'fruitsdata218', 'fruitsdata219', 'fruitsdata220', 'fruitsdata221', 'fruitsdata222', 'fruitsdata223', 'fruitsdata224', 'fruitsdata225', 'fruitsdata226', 'fruitsdata227', 'fruitsdata228', 'fruitsdata229', 'fruitsdata230', 'fruitsdata231', 'fruitsdata232', 'fruitsdata233', 'fruitsdata234', 'fruitsdata235', 'fruitsdata236', 'fruitsdata237', 'fruitsdata238', 'fruitsdata239', 'fruitsdata240', 'fruitsdata241', 'fruitsdata242', 'fruitsdata243', 'fruitsdata244', 'fruitsdata245', 'fruitsdata246', 'fruitsdata247', 'fruitsdata248', 'fruitsdata249', 'fruitsdata250'};
predictors = inputTable(:, predictorNames);
response = inputTable.fruitType;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Perform cross-validation
partitionedModel = crossval(trainedClassifier.ClassificationEnsemble, 'KFold', 5);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');

% Compute validation predictions and scores
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);
