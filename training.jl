include("forest_model.jl")
include("mv_regression.jl")

#train multivariable regression w 100 iters
function train_mv(features, labels, weight, learn_rate, iters)
    cost_history = []

    i = 0
    while i <= iters
        #calculate weights of the features
        weight = (gr_dsct_mv(features, labels, weight, learn_rate))

        # calculate the cost function using the weight iteration
        cost = (cost_function_mv(features, labels))
        push!(cost_history, cost)

        # print out the progress
        if i % 10 == 0
            print("iter = $i     weight = $weight    cost = $cost")
            println()
        end
        i += 1
    end
    return weight, cost_history
end
# tr_features = hcat(ones(size(tr_features,1), 1), tr_features)
train_mv(tr_features, tr_labels, c_weights, 0.0001, 100000)