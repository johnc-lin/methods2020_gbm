using DecisionTree
using DataFrames, DelimitedFiles
using Base

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

    # MSE and least squares
    prediction = predict_forest(features, labels)
    error_sq = (prediction-labels).^2
    # least_sq = (sum((error).^2))/(size(features)[1])
    
    return error_sq
end

#write forest model stats and predictions in output DelimitedFiles
# predictions
forest_predictions = predict_forest(test_features, test_labels)
println(forest_predictions)

model_type = fill("Forest", (123,1))

writedlm("forest_predictions.csv", [forest_predictions model_type], ',')

# MSE
forest_mse = stat_forest(test_features, test_labels)
println(forest_mse)
writedlm("forest_mse.csv", forest_mse, ',')