
a = trainedModel.predictFcn(diabetestraining);

correctPredictions = 0;

for i = 1:600
    if (a(i,1) == diabetestraining{i, 'label'})
        correctPredictions = correctPredictions + 1;
    end
end

% accuracy
accuracy = correctPredictions / 600 * 100;

disp(['Data percentage label Estimated correctly ( for training.csv): ', num2str(accuracy), '%']);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

b= trainedModel.predictFcn(diabetesvalidation);

correctPredictions = 0;

for i = 1:100
    if (a(i,1) == diabetesvalidation{i, 'label'})
        correctPredictions = correctPredictions + 1;
    end
end

% accuracy
accuracy = correctPredictions / 100 * 100;

disp(['Data percentage label Estimated correctly ( for validation.csv): ', num2str(accuracy), '%']);