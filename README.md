# ARIMA Time Series Forecasting 
This repository contains an implementation of ARIMA time series forecasting for the sales of Product A. The implementation is done in R and uses the following packages:

- 'tidyverse'
- 'forecast'
- 'evobiR'
- 'tseries'
- 'urca'
- 'TSstudio'
- 'Metrics'

###### Dataset
The sales data of Product A is stored in the file ProductA.csv. The dataset contains the sales quantity of Product A.

###### Data Preprocessing
- The dataset is split into training and testing sets with a ratio of 80:20.
- A time series object is created from the training data set.
- The training data set is cleaned using the sliding window method.
- The ACF and PACF of the time series object are plotted to check for stationarity.
- The time series object is differenced if needed to make it stationary.
- Tests for stationarity (ADF, PP, and KPSS tests) are performed on the time series object and the differenced time series object.
- The time series object is decomposed to understand its trend, seasonality, and residuals.

## ARIMA Modelling
- An ARIMA model is fit on the training data set.
- The model is used to forecast the sales for the testing data set.
- The mean absolute percentage error (MAPE) between the actual sales and the forecasted sales is calculated.
- A line plot is created to compare the actual and forecasted sales.

## Conclusion
The ARIMA model provides a good fit to the time series data and the forecasted sales are in line with the actual sales. The MAPE value gives an idea of how accurate the forecast is.


