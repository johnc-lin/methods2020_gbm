using DelimitedFiles
include("forest_model.jl")
include("mv_regression.jl")

#train multivariable regression w 100 iters
function train_mv(features, labels, weight, learn_rate, iters)
    cost_history = []

    i = 0
    while i <= iters
        #calculate weights of the features
        weight = (gr_dsct_mv(features, labels, weight, learn_rate))

        # calculate the cost function using the weight iteration
        cost = (cost_function_mv(features, labels))
        push!(cost_history, cost)

        # print out the progress
        # if i % 10 == 0
        #     print("iter = $i     weight = $weight    cost = $cost")
        #     println()
        # end
        i += 1
    end
    return weight, cost_history
end
# tr_features = hcat(ones(size(tr_features,1), 1), tr_features)
 final_weights, cost_list = train_mv(tr_features, tr_labels, c_weights, 0.0001, 1000)

#run the test files with final_weights
#predictions
mv_predicts = predict_mv(test_features, final_weights)
println(mv_predicts)

#MSE statistics
mean_sq = error_sq(test_features, final_weights, test_labels)
println(mean_sq)

#write predictions and statistics into separate files
writedlm("mv_predictions.csv", mv_predicts, ',')
writedlm("mv_mse.csv", mean_sq, ',')