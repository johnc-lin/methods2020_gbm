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
# println(mv_predicts)

#MSE statistics
mean_sq = error_sq(test_features, final_weights, test_labels)
# println(mean_sq)

forest_df = CSV.read("forest_predictions.csv")
real_df = CSV.read("real_final_data.csv")
original_df = DataFrame(Months = real_df[!,10], Model = fill("Original", 619))
mv_df = DataFrame(Months = mv_predicts, Model = fill("Multivariate", 123))

first_df = vcat(original_df, mv_df)
final_df = vcat(first_df, forest_df)
final_df[!, :Survival] .= 1
final_df[!, :NormalizedMonths] = log.(final_df.Months)
# print(final_df)

#write predictions and statistics into separate files
# writedlm("mv_predictions.csv", mv_predicts, ',')
CSV.write("final_predictions.csv", final_df)

forest_mse = CSV.read("forest_mse.csv")
mv_mse_df = DataFrame(MSE = mean_sq, Model = fill("Multivariate", 123))
final_mse = vcat(mv_mse_df, forest_mse)

CSV.write("final_mse.csv", final_mse)
# writedlm("mv_mse.csv", mean_sq, ',')