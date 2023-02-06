# Dynamic Regression

library(tidyverse)
library(forecast)
library(evobiR)
library(tseries)
library(urca)
library(TSstudio)

productA_sales <- read.csv("ProductA.csv")       # Read sales quantity from csv file
productA_google_clicks <- read.csv("ProductA_google_clicks.csv") # Read clicks data from csv file
productA_fb_impressions <- read.csv("ProductA_fb_impressions.csv") # Read impressions data from csv file

split_point <- floor(0.8 * nrow(productA_sales))

# Define time series object for sales 
productA_sales <- SlidingWindow("mean",productA_sales$Quantity,3,1)
productA_sales <- productA_sales[1:split_point]
productA_sales_ts <- ts(productA_sales, start = 1, frequency = 7)

# Cleaning variables using moving average and normalizing predictor variables
productA_google_clicks <- SlidingWindow("mean",productA_google_clicks$Clicks,3,1)
productA_google_clicks <- productA_google_clicks[1:split_point]
productA_google_clicks <- productA_google_clicks/(max(productA_google_clicks)-min(productA_google_clicks))

productA_fb_impressions <- SlidingWindow("mean",productA_fb_impressions$Impressions,3,1)
productA_fb_impressions <- productA_fb_impressions[1:split_point]
productA_fb_impressions <- productA_fb_impressions/(max(productA_fb_impressions)-min(productA_fb_impressions))

# Test for stationarity
kpss.test(productA_sales_ts)

# Dynamic Regression Modelling
fit_productA_sales <- auto.arima(productA_sales_ts, xreg = cbind(productA_google_clicks,productA_fb_impressions), seasonal = TRUE)
summary(fit_productA_sales)
checkresiduals(fit_productA_sales)


