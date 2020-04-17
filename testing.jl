using DecisionTree
using DataFrames

include("preprocessing_program.jl")
tr_features, tr_labels, test_features, test_labels = get_dataset()

# build model using training data
# uses 3 random features, 100 trees, 0.7 portions of samples per tree, 5 samples per leaf
# def_weights
w1 = 0.0
w2 = 0.0
w3 = 0.0
w4 = 0.0
w5 = 0.0
w6 = 0.0
d_weights = Array([w1,w2,w3,w4,w5,w6])

function predict(features, weights)
    labels = features * weights
    model = build_forest(labels, features, 3, 100, 0.7, 5)

    # #apply model 
    model_predictions = [apply_forest(model, features[i,:]) for i = 1:size(features)[1]]
    return model_predictions
end

# analyze accuracy of model_predications
# define cost function (kinda using least squares)
function cost_function(features, labels)
    prediction = predict(test_features, d_weights)
    least_sq = (sum((prediction - labels).^2))/(2*(size(features)[1]))
    return least_sq
end
testing = cost_function(test_features, test_labels)
println(testing)


# determine weights for model

function gr_dsct_forest(features, labels, weights, learn_rate)
    prediction = predict(features, d_weights)

    #extract features
    f1 = features[:, 1]
    f2 = features[:, 2]
    f3 = features[:, 3]
    f4 = features[:, 4]
    f5 = features[:, 5]
    f6 = features[:, 6]

    # calculate the derivatives of each weight
    # 𝑓′(𝑊1)=−𝑥1(𝑦−(𝑊1𝑥1+𝑊2𝑥2+𝑊3𝑥3))
    d_w1 = -1 * (cross(f1, (labels-prediction))) # WHY IS CROSS NOT DEFINED ? ERROR
    d_w2 = -1 *(cross(f2, (labels-prediction)))
    d_w3 = -1 *(cross(f3, (labels-prediction)))
    d_w4 = -1 *(cross(f4, (labels-prediction)))
    d_w5 = -1 *(cross(f5, (labels-prediction)))
    d_w6 = -1 *(cross(f6, (labels-prediction)))

    # apply 
    d_weights[1,1] -= (learn_rate * d_w1 / (size(features)))
    d_weights[2,1] -= (learn_rate * d_w2 / (size(features)))
    d_weights[3,1] -= (learn_rate * d_w3 / (size(features)))
    d_weights[4,1] -= (learn_rate * d_w4 / (size(features)))
    d_weights[5,1] -= (learn_rate * d_w5 / (size(features)))
    d_weights[6,1] -= (learn_rate * d_w6 / (size(features)))
    return d_weights
end

test_2 = gr_dsct_forest(test_features, test_labels, d_weights, 0.5)
println(test_2)


