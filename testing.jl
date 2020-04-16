using DecisionTree
using DataFrames

include("preprocessing_program.jl")
tr_features, tr_labels, test_features, test_leables = get_dataset()

# build model using training data
# uses 3 random features, 100 trees, 0.7 portions of samples per tree, 5 samples per leafjuli
model = build_forest(tr_labels, tr_features, 3, 100, 0.7, 5)

# #apply model 
println(apply_forest(model, test_features[1,:]))