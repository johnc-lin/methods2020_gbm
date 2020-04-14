# pre process data
import Missings
import Base


using CSV
using DataFrames
using Missings
using Base


gbm_df = CSV.File("$(Base.Filesystem.pwd())/gbm_final_data.csv", header = 1, footerskip = 0) |> DataFrame
gbm_final_df = gbm_df[:, [1,3,4,5,6,7,8,9,10]]

# for every missing unit, replace with -1 (michelle)
gbm_final_df = coalesce.(gbm_final_df, -1)


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
end

println(gbm_final_df)

# Here are some other things that I tried: 
    # gbm_final_df[() .== "Male", :Sex]="1"
    # gbm_final_df[(gbm_final_df.Sex) .== "Female", :Sex]="2"
    # map(row -> "1", skipmissing(gbm_final_df.Sex))
    # replace(replace(gbm_final_df.Sex[x], "Male" => "1"), "Female" => "2")

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
# print(gbm_final_df)




   



