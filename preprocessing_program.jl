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
    # 1 = Male, 0 = Female
    # 0 = Asian, 1 = Black/African American, 2 = White

    for k in 1:nrow(gbm_final_df)
        if gbm_final_df.Sex[k] == "Male"
            gbm_final_df.Sex[k] = 1
        elseif gbm_final_df.Sex[k] == "Female"
            gbm_final_df.Sex[k] = 0
        end
    end

    asian_category = []
    for value in gbm_final_df[!, 4]
        if value == "ASIAN"
            push!(asian_category, 1)
        else
            push!(asian_category, 0)
        end
    end

    aa_category = []
    for value in gbm_final_df[!, 4]
        if value == "BLACK OR AFRICAN AMERICAN"
            push!(aa_category, 1)
        else
            push!(aa_category, 0)
        end
    end

    w_category = []
    for value in gbm_final_df[!, 4]
        if value == "WHITE"
            push!(w_category, 1)
        else
            push!(w_category, 0)
        end
    end

    gbm_final_df = insertcols!(gbm_final_df, 4, asian = asian_category)
    gbm_final_df = insertcols!(gbm_final_df, 5, black = aa_category)
    gbm_final_df = insertcols!(gbm_final_df, 6, white = w_category)
    gbm_final_df = gbm_final_df[:, [1,2,3,4,5,6,8,9,10]]

    println(size(gbm_final_df))
    println(gbm_final_df)

            

function get_dataset()
    # split into training and testing features and labels (80/20)   
    training_features = gbm_final_df[1:floor(Int64, (0.8*size(gbm_final_df,1))), 1:end-1]
    training_labels = gbm_final_df[1:floor(Int64, (0.8*size(gbm_final_df,1))), end]
    testing_features = gbm_final_df[1:floor(Int64, (0.2*size(gbm_final_df,1))), 1:end-1]
    testing_labels = gbm_final_df[1:floor(Int64, (0.2*size(gbm_final_df,1))), end]

    # convert data fram into array
    training_features_array = convert(Array, training_features)
    training_labels_array = convert(Array, training_labels)
    testing_features_array = convert(Array, testing_features)
    testing_labels_array = convert(Array, testing_labels)

    #return values of the array
    return training_features_array, training_labels_array, testing_features_array, testing_labels_array
end

function get_dataset_dataframes()
    # split into training and testing features and labels (80/20)   
    training_features = gbm_final_df[1:floor(Int64, (0.8*size(gbm_final_df,1))), 1:end-1]
    training_labels = gbm_final_df[1:floor(Int64, (0.8*size(gbm_final_df,1))), end]
    testing_features = gbm_final_df[1:floor(Int64, (0.2*size(gbm_final_df,1))), 1:end-1]
    testing_labels = gbm_final_df[1:floor(Int64, (0.2*size(gbm_final_df,1))), end]

    return training_features, training_labels, testing_features, testing_labels
end
# println(gbm_final_df)
