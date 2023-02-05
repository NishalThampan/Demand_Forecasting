# Time- Series Analysis

library(tidyverse)
library(forecast)
library(evobiR)
library(tseries)
library(urca)
library(TSstudio)
library(Metrics)

setwd("D:/Demand_Forecasting")

productA <- read.csv("ProductA.csv") # Read sales quantity from csv file

# Splitting of time-series data into training and testing set

split_point <- floor(0.8 * nrow(productA))
productA_training <- productA[1:split_point,]
productA_testing <- productA[(split_point + 1):nrow(productA), ]

# Defining a time series object using the tarining data set 

productA_ts <- ts(productA_training$Quantity, start = 1, frequency = 7)
autoplot(productA_ts) + ggtitle("Product A sales") + labs(x = 'time', y = 'Sales')

productA_clean <- SlidingWindow("mean",productA_training$Quantity,3,1) # Cleaning of data set using sliding window
productA_ts <- ts(productA_clean, start = 1, frequency = 7)

autoplot(productA_ts) + ggtitle("Product A sales") + labs(x = 'time', y = 'Sales')

ggAcf(productA_ts) + ggtitle("ACF of sales")
ggPacf(productA_ts) + ggtitle("PACF of sales")

d_productA_ts <- diff(productA_ts)

ggAcf(d_productA_ts) + ggtitle("ACF")
ggPacf(d_productA_ts) + ggtitle("PACF")

# Decomposition of time series object

ts_decompose(productA_ts, type = "additive", showline = TRUE)

# Tests for stationarity

adf.test(productA_ts)
adf.test(productA_ts, k=1)
adf.test(productA_ts, k=2)

pp.test(productA_ts)
pp.test(d_productA_ts)

kpss.test(productA_ts)
kpss.test(d_productA_ts)

# ARIMA modelling

fit_productA_ts <- auto.arima(productA_ts)
summary(fit_productA_ts)

forecast <- data.frame(forecast(fit_productA_ts, h = nrow(productA)-split_point))
forecast <- forecast$Point.Forecast
productA_testing <- productA_testing$Quantity

mape(productA_testing,forecast)

view(forecast)

time_index <- 1:(nrow(productA)-split_point)

df <- data.frame(time_index, productA_testing, forecast)

plot(df$time_index, df$productA_testing, type = "l", col = "blue",
     xlab = "Time Index",
     ylab = "Values")
lines(df$time_index, df$forecast, col = "red")
