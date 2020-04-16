using DecisionTree
using DataFrames

include("preprocessing_program.jl")
tr_features, tr_labels, test_features, test_leables = get_dataset()

# build model using training data
# uses 35 random features, 1125 trees, 0.05 portions of samples per tree, 6 samples per leafjuli
model = build_forest(tr_labels, tr_features, 5, 1125, 0.05, 6)

# #apply model 
println(apply_forest(model, test_features[1,:]))




