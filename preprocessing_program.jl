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

# for every column create an average
mean_1 = mean(skipmissing(gbm_final_df[!, 1]))
mean_2 = mean(skipmissing(gbm_final_df[!, 2]))
# mean_3 = mean(skipmissing(gbm_final_df[!, 3]))
# mean_4 = mean(skipmissing(gbm_final_df[!, 4]))
mean_5 = mean(skipmissing(gbm_final_df[!, 5]))
mean_6 = mean(skipmissing(gbm_final_df[!, 6]))
mean_7 = mean(skipmissing(gbm_final_df[!, 7]))

# for every missing unit, replace with -1
gbm_final_df[!, 1] = coalesce.(gbm_final_df[!, 1], mean_1)
gbm_final_df[!, 2] = coalesce.(gbm_final_df[!, 2], mean_2)
gbm_final_df[!, 5] = coalesce.(gbm_final_df[!, 5], mean_5)
gbm_final_df[!, 6] = coalesce.(gbm_final_df[!, 6], mean_6)
gbm_final_df[!, 7] = coalesce.(gbm_final_df[!, 7], mean_7)

    # Assign each patient a numerical value based on their categorical data values:
    # 1 = Male, 0 = Female
    # col 4, 5, 6 = asian, black, white binary classification

    for k in 1:nrow(gbm_final_df)
        if gbm_final_df.Sex[k] == "Male"
            gbm_final_df.Sex[k] = 1
        elseif gbm_final_df.Sex[k] == "Female"
            gbm_final_df.Sex[k] = 0
        end
    end

    # mean_3 = mean(skipmissing(gbm_final_df.Sex))
    # gbm_final_df = coalesce.(gbm_final_df[!, 3], mean_3)

    asian_category = []
    for value in gbm_final_df[!, 4]
        if value == "ASIAN"
            push!(asian_category, 1)
        elseif value == "WHITE" || "BLACK OR AFRICAN AMERICAN"
            push!(asian_category, 0)
        end
    end

    aa_category = []
    for value in gbm_final_df[!, 4]
        if value == "BLACK OR AFRICAN AMERICAN"
            push!(aa_category, 1)
        elseif value == "ASIAN" || "WHITE"
            push!(aa_category, 0)
        end
    end

    w_category = []
    for value in gbm_final_df[!, 4]
        if value == "WHITE"
            push!(w_category, 1)
        elseif value == "ASIAN" || "BLACK OR AFRICAN AMERICAN"
            push!(w_category, 0)
        end
    end

    gbm_final_df = insertcols!(gbm_final_df, 4, asian = asian_category)
    gbm_final_df = insertcols!(gbm_final_df, 5, black = aa_category)
    gbm_final_df = insertcols!(gbm_final_df, 6, white = w_category)
    gbm_final_df = gbm_final_df[:, [1,2,3,4,5,6,8,9,10]]

    # mean_a = mean(skipmissing(gbm_final_df[!, 4]))
    # mean_aa = mean(skipmissing(gbm_final_df[!, 5]))
    # mean_w = mean(skipmissing(gbm_final_df[!, 6]))

    # gbm_final_df = coalesce.(gbm_final_df[!, 4], mean_a)
    # gbm_final_df = coalesce.(gbm_final_df[!, 5], mean_aa)
    # gbm_final_df = coalesce.(gbm_final_df[!, 6], mean_w)

    #  println(gbm_final_df)

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