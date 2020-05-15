library(ggplot2)
# Basic box plot

setwd("/Users/johnlin/github/gbm_ml/")

gbm_data <- read.csv("final_predictions.csv")

plot_1 <- ggplot(data = gbm_data, mapping = aes(x = Model, y = Months))
plot_1 + geom_boxplot() + labs(y="Overall Survival Time (Months)")


# mse_data <- read.csv("final_mse.csv")

# plot_2 <- ggplot(data = mse_data, mapping = aes(x = Model, y = MSE))
# plot_2 + geom_boxplot() + labs(y="Modern Standard Error (MSE)")