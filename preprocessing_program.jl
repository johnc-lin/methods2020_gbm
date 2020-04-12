# pre process data
import Missings
import Base

using CSV
using DataFrames
using Missings
using Base

gbm_df = CSV.File("$(Base.Filesystem.pwd())/gbm_final_data.csv", header = 1, footerskip = 0) |> DataFrame
gbm_final_df = gbm_df[:, [1,3,4,5,6,7,8,9,10]]

# for every empty unit, replace with -1 (michelle)
nrows, ncols = size(gbm_final_df)
for row in 1:nrows
    for col in 1:ncols
        Missings.replace(col, -1)
    end
end

# dictionary: sex (john)

#=for row in 1:nrows
    gbm_final_df[:Sex] = convert(DataArray{Union(String, Int64), 1}, gbm_final_df[:Sex])
    gbm_final_df[gbm_final_df[:Sex] .== "Male", :Sex] = 1
    gbm_final_df[gbm_final_df[:Sex] .== "Female", :Sex] = 2
=#
# dictionary: race (saba)

for row in 1:nrows
    race_dict = Dict()
    race_dict["ASIAN"] = "1"
    race_dict["BLACK OR AFRICAN AMERICAN"] = "2"
    race_dict["WHITE"] = "3"
        if haskey(race_dict, row)
            print("$(race_dict[row])")
        end
    end





   



