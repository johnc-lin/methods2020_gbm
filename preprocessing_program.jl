# pre process data
import Missings
import Base


using CSV
using DataFrames
using Missings
using Base
using Statistics


gbm_df = CSV.File("$(Base.Filesystem.pwd())/gbm_final_data.csv", header = 1, footerskip = 0) |> DataFrame
gbm_final_df = gbm_df[:, [1,3,4,5,6,7,8,9,10]]

# for every missing unit, replace with -1 (michelle)
gbm_final_df = coalesce.(gbm_final_df, -1)
#print(gbm_final_df)



# John: Assign each patient a numerical value based on their sex:
# 1 = Male, 2 = Female
k=0
for row in gbm_final_df.Sex
    global k += 1
    if gbm_final_df.Sex[k] == "Male"
        gbm_final_df.Sex[k] = 1
    else
        gbm_final_df.Sex[k] = 2
    end
end

# 1 = Asian, 2 = Black/African American, 3 = White
s=0
for row in gbm_final_df[!, 6]
    global s += 1
    if gbm_final_df[!, 6][s] == "ASIAN"
        gbm_final_df[!, 6][s] = 1
    elseif gbm_final_df[!, 6][s] == "BLACK OR AFRICAN AMERICAN"
        gbm_final_df[!, 6][s] = 2
    elseif gbm_final_df[!, 6][s] == "WHITE" 
        gbm_final_df[!, 6][s] = 3
    end
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

#CSV.write("/Users/sabaparacha/methods2020/gbm_ml/processed_data.csv", gbm_final_df)





   



