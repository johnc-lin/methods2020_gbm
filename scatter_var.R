library(ggplot2)
# Basic box plot

setwd("/Users/michellemai/gbm_ml/")


gbm_data <- read.csv("real_final_data.csv")
newname<-list("genome_altered","age","male","female","asian","black","white","disease_free","KPS","OS")
names(gbm_data) <- newname

# plot_1 <- ggplot(data = gbm_data, mapping = aes(x = genome_altered, y = OS))
# plot_1 + geom_point() +
# scale_y_continuous(trans="log10", limits=c(-150,150)) +
# geom_smooth(method = "lm", se = TRUE, color ='red') +
# labs(y = "log of Overall Survival (months)", x = "Fraction of Genome Altered", title = "Overall Survival vs Fraction of Genome Altered trend")
# ggsave("genome_OS.png")

# plot_2 <- ggplot(data = gbm_data, mapping = aes(x = age, y = OS))
# plot_2 + geom_point() +
# scale_y_continuous(trans="log10", limits=c(-150,150)) +
# geom_smooth(method = "lm", se = TRUE, color ='red') +
# labs(y = "log of Overall Survival (months)", x = "Age (years)", title = "Overall Survival vs Age trend")
# ggsave("age_OS.png")

# plot_3 <- ggplot(data = gbm_data, mapping = aes(x = male, y = OS))
# plot_3 + geom_boxplot(aes(group = cut_width(male, 1))) +
#   scale_y_continuous(trans="log10", limits=c(-150, 150)) +
#   scale_x_continuous(breaks = c(0,1), labels = c("Not male", "Male")) +
#   labs(y = "log of Overall Survival (months)", x = "Gender Category", title = "Overall Survival vs Gender trend")
# ggsave("male_OS.png")

# plot_4 <- ggplot(data = gbm_data, mapping = aes(x = white, y = OS))
# plot_4 + geom_boxplot(aes(group = cut_width(white, 1))) +
# scale_y_continuous(trans="log10", limits=c(-150, 150)) +
#   scale_x_continuous(breaks = c(0,1), labels = c("Not white", "White")) +
#   labs(y = "log of Overall Survival (months)", x = "Race Category", title = "Overall Survival vs Race trend")
# ggsave("race_OS.png")

plot_6 <- ggplot(data = gbm_data, mapping = aes(x = KPS, y = OS))
plot_6 + 
   geom_boxplot(aes(group = cut_width(KPS, 1))) +
  scale_y_continuous(trans="log10", limits=c(-150, 150)) +
  geom_smooth(method = "lm", se = TRUE, color ='red') +
    labs(y = "log of Overall Survival (months)", x = "KPS Score", title = "Overall Survival vs KPS trend")
  ggsave("KPS_OS.png")