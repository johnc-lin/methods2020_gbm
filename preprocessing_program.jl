# pre process data
import Missings
import Base

using CSV
using DataFrames
using Missings
using Base
using Statistics

gbm_df = CSV.File("$(Base.Filesystem.pwd())/gbm_final_data.csv", header = 1, footerskip = 0) |> DataFrame
gbm_final_df = gbm_df[:, [4,5,6,7,8,9,10]]

# for every missing unit, replace with -1
gbm_final_df = coalesce.(gbm_final_df, -1)

    # Assign each patient a numerical value based on their categorical data values:
    # 1 = Male, 2 = Female
    # 1 = Asian, 2 = Black/African American, 3 = White

    for k in 1:nrow(gbm_final_df)
        if gbm_final_df.Sex[k] == "Male"
            gbm_final_df.Sex[k] = 1
        elseif gbm_final_df.Sex[k] == "Female"
            gbm_final_df.Sex[k] = 2
        end
        if gbm_final_df[!, 4][k] == "ASIAN"
            gbm_final_df[!, 4][k] = 1
        elseif gbm_final_df[!, 4][k] == "BLACK OR AFRICAN AMERICAN"
            gbm_final_df[!, 4][k] = 2
        elseif gbm_final_df[!, 4][k] == "WHITE" 
            gbm_final_df[!, 4][k] = 3
        end
    end

function get_dataset()
    # split into training and testing features and labels (80/20)   
    training_features = gbm_final_df[1:floor(Int64, (0.8*size(gbm_final_df,1))), 1:end-1]
    training_labels = gbm_final_df[1:floor(Int64, (0.8*size(gbm_final_df,1))), 1:end]
    testing_features = gbm_final_df[1:floor(Int64, (0.2*size(gbm_final_df,1))), 1:end-1]
    testing_labels = gbm_final_df[1:floor(Int64, (0.2*size(gbm_final_df,1))), 1:end]
    # convert data fram into array
    training_features_array = convert(Matrix, training_features)
    training_labels_array = convert(Matrix, training_labels)
    testing_features_array = convert(Matrix, testing_features)
    testing_labels_array = convert(MathConstants, testing_labels)
    #return values of the array
    return training_features_array, training_labels_array, testing_features_array, testing_labels_array
end
# println(gbm_final_df)
