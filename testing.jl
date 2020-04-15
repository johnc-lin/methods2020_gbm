using DecisionTree

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
