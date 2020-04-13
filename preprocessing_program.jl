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
#=nrows, ncols = size(gbm_final_df)
for row in 1:nrows
    for col in 1:ncols
        coalesce.(col, -1)
        
    end
end
print(gbm_final_df)
=#



# dictionary: sex (john)skipmissing  skipmissing
gbm_final_df[(gbm_final_df.Sex) .== "Male", :Sex]="1"
gbm_final_df[(gbm_final_df.Sex) .== "Female", :Sex]="2"
#=for row in skipmissing(gbm_final_df.Sex)
    replace(replace(row, "Male" => "1"), "Female" => "2")
    print(row)
end =#
print(gbm_final_df.Sex)
# dictionary: race (saba)
# dictionary didn't do squat :( 
#=for race_value in gbm_final_df
    race_dict = Dict()
    race_dict["ASIAN"] = "1"
    race_dict["BLACK OR AFRICAN AMERICAN"] = "2"
    race_dict["WHITE"] = "3"
    race_dict["missing"] = "-1"
        if haskey(race_dict, race_value)
            print("$(race_dict[race_value])")
        end
    end 
=#
print(gbm_final_df)




   



