using CSV
using Statistics
using DataFrames
using Plots
pred_df = CSV.File("$(Base.Filesystem.pwd())/final_predictions.csv", header = 1, footerskip = 0) |> DataFrame

#forest CI with logging to normalize
rf_pred_df = pred_df[743:865, 1]
rf_array = []
rf_array = convert(Array, rf_pred_df)
rf_pred_log = log.(rf_array[1:123])
rf_p_mean = mean(rf_pred_log)
rf_p_std = std(rf_pred_log)
upper_limit_rf = rf_p_mean + (2 * rf_p_std)
lower_limit_rf = rf_p_mean - (2 * rf_p_std)

#println("the 95% confidence interval for the Random Forest logged is $lower_limit_rf months to $upper_limit_rf months")

#multivariate regression CI
mv_pred_df = pred_df[620:742, 1]
mv_array = []
mv_array = convert(Array, mv_pred_df)
mv_pred_log = log.(mv_array[1:123])
mv_p_mean = mean(mv_pred_log)
mv_p_std = std(mv_pred_log)
upper_limit_mv = mv_p_mean + (2 * mv_p_std)
lower_limit_mv = mv_p_mean - (2 * mv_p_std)

#println("the 95% confidence interval for the MV regression is $lower_limit_mv months to $upper_limit_mv months") 

#og data time
og_pred_df = pred_df[1:619, 1]
og_array = []
og_array = convert(Array, og_pred_df)

#finding quartiles and iqr to make outlier boundries
og_q1 = quantile(og_array, .25)
og_q3 = quantile(og_array, .75)
og_iqr = og_q3 - og_q1
lower_ol_boundry = og_q1 - (1.5 * og_iqr)
upper_ol_boundry = og_q3 + (1.5 * og_iqr)

#cutting out outliers
actual_og_data = []
outliers_og = []
for value in og_array[1:123]
    if lower_ol_boundry <= value <= upper_ol_boundry
        push!(actual_og_data, value)
    else 
        push!(outliers_og, 1)
    end
end
#println(length(actual_og_data))
#logging data for comparision and normaization
og_pred_log = log.(actual_og_data[1:107])
#println(og_pred_log)

#finding accuracy of forest model
accuracy_forest = []
inaccuracy_forest = []
for value in og_pred_log[1:107]
    if lower_limit_rf <= value <= upper_limit_rf
        push!(accuracy_forest, 1)
    else 
        push!(inaccuracy_forest, 1)
    end
end
percent_forest_acc = ((length(accuracy_forest))/107) * 100
println("the Random Forest was $percent_forest_acc% accurate")

#finding accuracy of mv model
accuracy_mv = []
inaccuracy_mv = []
for value in og_pred_log[1:107]
    if lower_limit_mv <= value <= upper_limit_mv
        push!(accuracy_mv, 1)
    else 
        push!(inaccuracy_mv, 1)
    end
end
percent_mv_acc = ((length(accuracy_mv))/107) * 100
println("the Multivariate regression was $percent_mv_acc% accurate")






