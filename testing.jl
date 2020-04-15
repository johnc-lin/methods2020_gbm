using DecisionTree
using DataFrames

include("preprocessing_program.jl")
loading_dataset()

# labels_training, features_training = load_data("gbm_testing_array")
println(labels_training)

# build model using training data
# uses 3 random features, 100 trees, 0.7 portions of samples per tree, 5 samples per leaf
# model = build_forest( 3, 100, 0.7, 5)

# #apply model 
# apply_forest(model, )