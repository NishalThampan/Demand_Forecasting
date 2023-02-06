# Demand Forecasting for E-Commerce

This repository contains implementations of various demand forecasting models that can be used for an E-Commerce environment. The models used are ARIMA time series forecasting and Regression using Digital Marketing KPIS. The implementation is done in R. 

## ARIMA Time Series Forecasting 
The file for ARIMA time series forecasting is 'ProductA_timeseries.R'. The implementation uses the following packages:

- **'tidyverse'**
- **'forecast'**
- **'evobiR'**
- **'tseries'**
- **'urca'**
- **'TSstudio'**
- **'Metrics'**

###### Dataset
The sales data of Product A is stored in the file ProductA.csv. The dataset contains the sales quantity of Product A. The data can be extracted from the Google Analytics dashboard of the corresponding E-Commerce website. 

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

## Multivariate Regression in R
This is another model that performs a multivariate regression of sales of "ProductA" on two predictor variables: google clicks and facebook impressions. These are two Digital Marketing KPIs that influence the sales of a product. Google clicks refers to the number of clicks associated with a particular Google Ads campaign that drove the sales of a particular product (here it is Product A). Similarly, Facebook Impressions refers to the number of impressions associated with a particular Facebook Ads campaign that drove the sales of a particular product. The file for this model is 'ProductA_Multivariate_Regression.R'. The implementation uses the following packages:

- **'tidyverse'**
- **'evobiR'**
- **'MLmetrics'**
- **'Metrics'**

###### Dataset
The code requires three data sets:

"ProductA.csv" which contains sales quantity data.
"ProductA_google_clicks.csv" which contains clicks data.
"ProductA_fb_impressions.csv" which contains impressions data.

##### Execution
The code first loads the required packages and reads in the three data sets. Then, the data is cleaned using moving average and normalizing the predictor variables. The data sets are merged into a single data frame and split into training and testing sets.

A multivariate regression model is fit using the "lm" function in R, with sales as the response variable and google clicks and facebook impressions as the predictor variables. The model summary is displayed and the model is used to make predictions on the testing data.

Finally, three evaluation metrics (Mean Absolute Percentage Error (MAPE), Mean Squared Error (MSE), and Root Mean Squared Error (RMSE)) are calculated to assess the performance of the model.

##### ontributing
If you have any suggestions or improvements, feel free to create a pull request.
