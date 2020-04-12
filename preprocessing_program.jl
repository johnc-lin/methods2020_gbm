# pre process data

using CSV
using DataFrames

gbm_df = CSV.File("/Users/johnlin/github/gbm_ml/gbm_final_data.csv", header = 1, footerskip = 0) |> DataFrame
gbm_final_df = gbm_df[:, [1,3,4,5,6,7,8,9,10]]

# for every empty unit, replace with -1 (michelle)
nrows, ncols = size(gbm_final_df)
for row in 1:nrows
    for col in 1:ncols
        coalesce.(, -1)
    end
end

# dictionary: sex (john)

#for row in 1:nrows
    gbm_final_df[:Sex] = convert(DataArray{Union(String, Int64), 1}, gbm_final_df[:Sex])
    gbm_final_df[gbm_final_df[:Sex] .== "Male", :Sex] = 1
    gbm_final_df[gbm_final_df[:Sex] .== "Female", :Sex] = 2
#end
# dictionary: race (saba)



