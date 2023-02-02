# Time- Series Analysis

library(tidyverse)
library(forecast)
library(evobiR)
library(tseries)
library(urca)
library(TSstudio)

setwd("C:/Users/user/Desktop/OneDrive - The University of Nottingham/Dissertation/TAOS/Data/csv_files")

lavender_seeds <- read.csv("lavender_seeds_quantity.csv") # Read sales quantity from csv file

lavender_seeds_ts <- ts(lavender_seeds$Quantity, start = 1, frequency = 7)
autoplot(lavender_seeds_ts) + ggtitle("lavender seeds sales") + labs(x = 'time', y = 'Sales')

lavender_seeds_clean <- SlidingWindow("mean",lavender_seeds$Quantity,3,1)
lavender_seeds_clean <- lavender_seeds_clean[1:170]
lavender_seeds_ts <- ts(lavender_seeds_clean, start = 1, frequency = 7)


autoplot(lavender_seeds_ts) + ggtitle("lavender seeds sales") + labs(x = 'time', y = 'Sales')

ggAcf(lavender_seeds_ts) + ggtitle("ACF of sales")
ggPacf(lavender_seeds_ts) + ggtitle("PACF of sales")

d_lavender_seeds <- diff(lavender_seeds_ts)

ggAcf(d_lavender_seeds) + ggtitle("ACF")
ggPacf(d_lavender_seeds) + ggtitle("PACF")

ts_decompose(lavender_seeds_ts, type = "additive", showline = TRUE)

adf.test(lavender_seeds_ts)
adf.test(lavender_seeds_ts, k=1)
adf.test(lavender_seeds_ts, k=2)

pp.test(lavender_seeds_ts)
pp.test(d_lavender_seeds)

kpss.test(lavender_seeds_ts)
kpss.test(d_lavender_seeds)

# ARIMA modelling

fit_arima_lavender <- auto.arima(lavender_seeds_ts)
summary(fit_arima_lavender)

extract_eq(fit_arima_lavender)

checkresiduals(fit_arima_lavender)

forecast(fit_arima_lavender, h = 14)
f_testing <- lavender_seeds$Quantity[171:185]
forecast <- data.frame(forecast(fit_arima_lavender, h = 14))
forecast <- forecast$Point.Forecast
forecast <- data.frame(forecast)

mape(f_testing,forecast)

f_testing

