# Multivariate Regression

library(tidyverse)
library(evobiR)
library(MLmetrics)
library(Metrics)

productA_sales <- read.csv("ProductA.csv")       # Read sales quantity from csv file
productA_google_clicks <- read.csv("ProductA_google_clicks.csv") # Read clicks data from csv file
productA_fb_impressions <- read.csv("ProductA_fb_impressions.csv") # Read impressions data from csv file

# Cleaning variables using moving average and normalizing predictor variables 

productA_google_clicks <- SlidingWindow("mean",productA_google_clicks$Clicks,3,1)
productA_google_clicks <- productA_google_clicks/(max(productA_google_clicks)-min(productA_google_clicks))

productA_fb_impressions <- SlidingWindow("mean",productA_fb_impressions$Impressions,3,1)
productA_fb_impressions <- productA_fb_impressions/(max(productA_fb_impressions)-min(productA_fb_impressions))

productA_sales <- SlidingWindow("mean",productA_sales$Quantity,3,1)

regression_productA_sales <- data.frame(productA_sales, productA_google_clicks, productA_fb_impressions )
colnames(regression_productA_sales) <- c('sales','google_clicks', 'fb_impressions')

#Splitting data into training and testing data sets

split_point <- floor(0.9 * nrow(regression_productA_sales))
productA_training <- regression_productA_sales[1:split_point,]
productA_testing <- regression_productA_sales[(split_point + 1):nrow(regression_productA_sales), ]

# Multivariate Regression model

fit_productA_sales <- lm(sales ~ google_clicks + fb_impressions, data = productA_training)

summary(fit_productA_sales)

predict(fit_productA_sales, productA_testing )

forecast <- predict(fit_productA_sales, productA_testing)

mape(productA_testing$sales,forecast)
mse(productA_testing$sales,forecast)
rmse(productA_testing$sales,forecast)




