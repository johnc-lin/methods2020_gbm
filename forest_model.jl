using DecisionTree
using DataFrames, DelimitedFiles
using Base, CSV

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
    error = prediction-labels
    # least_sq = (sum((error).^2))/(size(features)[1])
    
    return error_sq, error
end

#write forest model stats and predictions in output DelimitedFiles
# predictions
predictions = predict_forest(test_features, test_labels)
forest_predictions = DataFrame(Months = predictions, Model = fill("Forest", 123))

CSV.write("forest_predictions.csv",  forest_predictions)
# writedlm("forest_predictions.csv", [forest_predictions model_type], ',')

# MSE, RMSE, MAE
all_errors_sq, all_errors = stat_forest(test_features, test_labels)
avg_mse = sum(all_errors_sq)/size(all_errors_sq,1)
println(avg_mse)

avg_rmse = sqrt(avg_mse)
println(avg_rmse)

abs_errors = abs.(all_errors)
mae = sum(abs_errors)/size(all_errors,1)
println(mae)

# forest_mse = DataFrame(MSE = mse_values, Model = fill("Forest", 123))
# CSV.write("forest_mse.csv", forest_mse)