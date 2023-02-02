
library(tidyverse)
library(forecast)
library(evobiR)
library(tseries)
library(urca)
library(TSstudio)

setwd("C:/Users/user/Desktop/OneDrive - The University of Nottingham/Dissertation/TAOS/Data/csv_files")

lavender_seeds <- read.csv("lavender_seeds_quantity.csv") # Read sales quantity from csv file
lavender_seeds_google <- read.csv("lavender_seeds_google.csv") # Read clicks data from csv file
lavender_seeds_fb <- read.csv("lavender_seeds_fb.csv") # Read impressions data from csv file
lavender_seeds_fb <- lavender_seeds_fb[1:212,]

lavender_seeds_clean <- SlidingWindow("mean",lavender_seeds$Quantity,3,1)
lavender_seeds_clean <- lavender_seeds_clean[1:170]
lavender_seeds_ts <- ts(lavender_seeds_clean, start = 1, frequency = 7)

lavender_seeds_google_clean <- SlidingWindow("mean",lavender_seeds_google$Clicks,3,1)
lavender_seeds_google_clean <- lavender_seeds_google_clean[1:170]
lavender_seeds_google_clean_norm <- lavender_seeds_google_clean/(max(lavender_seeds_google_clean)-min(lavender_seeds_google_clean))
lavender_seeds_google_ts <- ts(lavender_seeds_google_clean_norm, start = 1, frequency = 7)

lavender_seeds_fb_clean <- SlidingWindow("mean",lavender_seeds_fb$Impressions,3,1)
lavender_seeds_fb_clean <- lavender_seeds_fb_clean[1:170]
lavender_seeds_fb_clean_norm <- lavender_seeds_fb_clean/(max(lavender_seeds_fb_clean)-min(lavender_seeds_fb_clean))
lavender_seeds_fb_ts <- ts(lavender_seeds_fb_clean_norm, start = 1, frequency = 7)

kpss.test(lavender_seeds_google_ts)

fit_arima_lavender <- auto.arima(lavender_seeds_ts, xreg = cbind(lavender_seeds_google_ts,lavender_seeds_fb_ts), seasonal = TRUE)
summary(fit_arima_lavender)
checkresiduals(fit_arima_lavender)

fit_arima_lavender <- auto.arima(lavender_seeds_ts, xreg = lavender_seeds_google_ts)
summary(fit_arima_lavender)

clicks <- lavender_seeds_google$Clicks[171:184]
clicks_norm <- clicks/(max(clicks)-min(clicks))
impressions <- lavender_seeds_fb$Impressions[171:184]
impressions_norm <- impressions/(max(impressions)-min(impressions))
xreg <- data.frame(clicks_norm, impressions_norm)
forecast(fit_arima_lavender ,h = 14, xreg=xreg)


fit_arima_lavender <- auto.arima(lavender_seeds_ts, xreg = cbind(lavender_seeds_google_ts,lavender_seeds_fb_ts), seasonal = TRUE)

summary(fit_arima_lavender)
checkresiduals(fit_arima_lavender)

clicks <- data.frame(lavender_seeds_google$Clicks)
clicks <- clicks[171:184,]
predict(fit_arima_lavender,n.ahead = 14, newxreg=clicks)


forecast(fit_arima_lavender ,h = 3, xreg = cbind(113, 113, 113))

