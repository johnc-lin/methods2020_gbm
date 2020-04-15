# pre process data

import Missings
import Base

using CSV
using DataFrames
using Missings
using Base
using Statistics

function loading_data()
gbm_df = CSV.File("$(Base.Filesystem.pwd())/gbm_final_data.csv", header = 1, footerskip = 0) |> DataFrame
gbm_final_df = gbm_df[:, [4,5,6,7,8,9,10]]

# for every missing unit, replace with -1
gbm_final_df = coalesce.(gbm_final_df, -1)

fraction_genome_altered = mean(gbm_final_df[!, 3])

# John: Assign each patient a numerical value based on their sex:
# 1 = Male, 2 = Female
k=0
for row in gbm_final_df.Sex
    global k += 1
    if gbm_final_df.Sex[k] == "Male"
        gbm_final_df.Sex[k] = 1
    elseif gbm_final_df.Sex[k] == "Female"
        gbm_final_df.Sex[k] = 2
    end
#=
convert(AbstractFloat, gbm_final_df[!, 3])
a=0
for missing_value in gbm_final_df[!, 3]
    global a += 1
    if missing_value[a] == -1
        gbm_final_df[!, 3][a] = mean(gbm_final_df[!, 3])
    end
end
#println(gbm_final_df.Sex)
#println(gbm_final_df[!, 6])
 =#

   # println(gbm_final_df)

    # split into training and testing data set (about 80/20)
    gbm_training_df = first(gbm_final_df, 495)
    gbm_testing_df = last(gbm_final_df, 125)
    
    # convert data fram into array
    gbm_training_array = convert(Matrix, gbm_training_df[:, :])
    gbm_testing_array = convert(Matrix, gbm_testing_df[:, :])
   # print(gbm_training_array)

   #load data into features and labels
   labels_training = convert(Matrix, gbm_training_df[:, 10])
   features_training = convert(Matrix, gbm_training_df[:, [4-9]])
end

#write the data frame into a CSV file
#CSV.write("gbm_pp_data.csv", gbm_final_df)