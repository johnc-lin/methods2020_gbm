library(ggplot2)
# Basic box plot

setwd("/Users/johnlin/github/gbm_ml/")

gbm_data <- read.csv("forest_mse.csv")

plot_1 <- ggplot(data = gbm_data, mapping = aes(x = V2, y = V1))
plot_1 + geom_boxplot()

