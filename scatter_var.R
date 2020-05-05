library(ggplot2)
# Basic box plot

setwd("/Users/michellemai/gbm_ml/")


gbm_data <- read.csv("real_final_data.csv")
newname<-list("genome_altered","age","male","female","asian","black","white","disease_free","KPS","OS")
names(gbm_data) <- newname

plot_1 <- ggplot(data = gbm_data, mapping = aes(x = genome_altered, y = OS))
plot_1 + geom_point()

plot_2 <- ggplot(data = gbm_data, mapping = aes(x = age, y = OS))
plot_2 + geom_point()

plot_3 <- ggplot(data = gbm_data, mapping = aes(x = male, y = OS))
plot_3 + geom_point()

plot_4 <- ggplot(data = gbm_data, mapping = aes(x = white, y = OS))
plot_4 + geom_point()

plot_5 <- ggplot(data = gbm_data, mapping = aes(x = disease_free, y = OS))
plot_5 + geom_point()

plot_6 <- ggplot(data = gbm_data, mapping = aes(x = KPS, y = OS))
plot_6 + geom_point()

# gbm_data <- read.csv("final_predictions.csv")

# plot_1 <- ggplot(data = gbm_data, mapping = aes(x = Model, y = Months))
# plot_1 + geom_boxplot()
