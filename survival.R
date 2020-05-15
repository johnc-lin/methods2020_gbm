library(ggplot2)
library(ggfortify)
library(survival)

setwd("/Users/johnlin/github/gbm_ml/")

gbm_data <- read.csv("final_predictions.csv")

fit <- survfit(Surv(Months, Survival) ~ Model, data = gbm_data)
autoplot(fit) + labs(y= "Overall Survival (%)", x="Time (months)")
