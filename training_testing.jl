include("forest_model.jl")

#train forest model by running 100 iterations
function train_forest(features, labels, weight, learn_rate, iters)
    cost_history = []

    i = 0
    while i <= iters
        #calculate weights of the features
        weight = gr_dsct_forest(features, labels, weight, learn_rate)

        # calculate the cost function using the weight iteration
        cost = cost_function(features, labels)
        push!(cost_history, cost)

        # print out the progress
        if i % 10 == 0
            print("iter = $i     weight = $weight    cost = $cost")
        end
        i += 1
    end
    return weight, cost_history
end

println(train_forest(tr_features, tr_labels, d_weights, 0.5, 100))