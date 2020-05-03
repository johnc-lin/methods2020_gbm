# Multivariate regression

include("preprocessing_program.jl")

tr_features, tr_labels, test_features, test_labels = get_dataset()

# build model using training data
# def_weights
w1 = 0.0
w2 = 0.0
w3 = 0.0
w4 = 0.0
w5 = 0.0
w6 = 0.0
w7 = 0.0
w8 = 0.0
w9 = 0.0

c_weights = Array([w1;w2;w3;w4;w5;w6;w7;w8;w9]) #dimensions = 10x1
# d_weights, cost_history = train_mv(tr_features, tr_labels, c_weights, 0.0001, 1000)

function predict_mv(features, weights)
    model_predictions = features * weights
    return model_predictions
end
# test = predict_mv(tr_features, c_weights)
# print(test)

# analyze accuracy of model_predications
#error of predictions-labels
function error_sq(features, weights, labels)
    predictions = predict_mv(features, weights)
    error_sq = (predictions - labels).^2
    return error_sq
end

# define cost function (kinda using least squares)
function cost_function_mv(features, labels)
    prediction = predict_mv(features, c_weights)
    mse = (sum((prediction - labels).^2))/(size(features)[1])
    return mse/2
end
# testing = cost_function_mv(test_features, test_labels)
# println(testing)


# determine weights for model

function gr_dsct_mv(features, labels, weights, learn_rate)
    prediction = predict_mv(features, c_weights)

    #extract features
    f1 = features[:, 1]
    f2 = features[:, 2]
    f3 = features[:, 3]
    f4 = features[:, 4]
    f5 = features[:, 5]
    f6 = features[:, 6]
    f7 = features[:, 7]
    f8 = features[:, 8]
    f9 = features[:, 9]

    # calculate the derivatives of each weight
    # 𝑓′(𝑊1)=−𝑥1(𝑦−(𝑊1𝑥1+𝑊2𝑥2+𝑊3𝑥3))
    c_w1 = -1 * transpose(f1) * (labels-prediction)
    c_w2 = -1 * transpose(f2) * (labels-prediction)
    c_w3 = -1 * transpose(f3) * (labels-prediction)
    c_w4 = -1 * transpose(f4) * (labels-prediction)
    c_w5 = -1 * transpose(f5) * (labels-prediction)
    c_w6 = -1 * transpose(f6) * (labels-prediction)
    c_w7 = -1 * transpose(f7) * (labels-prediction)
    c_w8 = -1 * transpose(f8) * (labels-prediction)
    c_w9 = -1 * transpose(f9) * (labels-prediction)
    
    # apply 
    c_weights[1,1] -= (learn_rate * c_w1 / 619) 
    c_weights[2,1] -= (learn_rate * c_w2 / 619) # figure out a way to make this more universal
    c_weights[3,1] -= (learn_rate * c_w3 / 619)
    c_weights[4,1] -= (learn_rate * c_w4 / 619)
    c_weights[5,1] -= (learn_rate * c_w5 / 619)
    c_weights[6,1] -= (learn_rate * c_w6 / 619)
    c_weights[7,1] -= (learn_rate * c_w7 / 619)
    c_weights[8,1] -= (learn_rate * c_w8 / 619)
    c_weights[9,1] -= (learn_rate * c_w9 / 619)

    # c_weights -= (learn_rate/619) .* transpose(transpose(prediction-labels)*features) 
    return c_weights
end