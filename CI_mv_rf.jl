using CSV
using Statistics
using DataFrames

pred_df = CSV.File("$(Base.Filesystem.pwd())/final_predictions.csv", header = 1, footerskip = 0) |> DataFrame
#forest CI
rf_pred_df = pred_df[743:865, 1]

rf_array = convert(Array, rf_pred_df)
rf_p_mean = mean(rf_array)
rf_p_std = std(rf_array)
upper_limit = rf_p_mean + (2 * rf_p_std)
lower_limit = rf_p_mean - (2 * rf_p_std)

println("the 95% confidence interval for the Random Forest is $lower_limit months to $upper_limit months")

#multivariate regression CI
mv_pred_df = pred_df[620:742, 1]

mv_array = convert(Array, mv_pred_df)
mv_p_mean = mean(mv_array)
mv_p_std = std(mv_array)
upper_limit = mv_p_mean + (2 * mv_p_std)
lower_limit = mv_p_mean - (2 * mv_p_std)

println("the 95% confidence interval for the MV regression is $lower_limit months to $upper_limit months")