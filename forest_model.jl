using DecisionTree
using DataFrames

include("preprocessing_program.jl")
tr_features, tr_labels, test_features, test_labels = get_dataset()

function predict_forest(features, labels)
        model = build_forest(labels, features, 3, 100, 0.7, 5)
    
        # #apply model 
        model_predictions = [apply_forest(model, features[i,:]) for i = 1:size(features)[1]]
        return model_predictions
    end
# test = predict_forest(tr_features, tr_labels)
# print(test)

# model evaluation
function stat_forest(features, labels) # n_subfeatures, n_folds
    #r2 regression stats
    #r2 = nfoldCV_forest(labels, features, n_folds, n_subfeatures)

    # MSE
    prediction = predict_forest(features, labels)
    least_sq = (sum((prediction - labels).^2))/(size(features)[1])
    
    return least_sq
end