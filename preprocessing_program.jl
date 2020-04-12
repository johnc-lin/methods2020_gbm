# pre process data
import Missings
import Base

using CSV
using DataFrames
using Missings
using Base

gbm_df = CSV.File("$(Base.Filesystem.pwd())/gbm_ml/gbm_final_data.csv", header = 1, footerskip = 0) |> DataFrame
gbm_final_df = gbm_df[:, [1,3,4,5,6,7,8,9,10]]

# for every empty unit, replace with -1 (michelle)
nrows, ncols = size(gbm_final_df)
for row in 1:nrows
    for col in 1:ncols
        missings.replace(x, -1)
    end
end

# dictionary (2): sex (john), race category (saba)



