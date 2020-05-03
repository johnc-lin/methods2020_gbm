library(ggplot2)
# Basic box plot

setwd("/Users/johnlin/github/gbm_ml/")

gbm_data <- read.csv("forest_predictions.csv")

plot_1 <- ggplot(data = gbm_data, mapping = aes(x = Model, y = Months))
plot_1 + geom_boxplot()

