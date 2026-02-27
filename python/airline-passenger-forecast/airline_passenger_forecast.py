import pandas as pd
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
import numpy as np

df = pd.read_csv("airtravel.csv")

#Quick data check
# df.shape
# df.info()
# df.describe()
# df.isnull().sum()
# df.head()


#Sorting out the columns for structure
df_long.columns
df_long = pd.melt(
    df,
    id_vars=["Month"],
    var_name="Year",
    value_name="Passengers")



#Clean Year Month 
df_long["Year"] = df_long["Year"].astype(str).str.replace('"', '', regex=False).astype(int)
df_long["Month"] = df_long["Month"].astype(str).str.strip().str.title()

#Create Datetime series
df_long["Date"] = pd.to_datetime(
    df_long["Month"] + " " + df_long["Year"].astype(str),
    format="%b %Y",
    errors="raise")

#Sort for rolling average
df_long = df_long.sort_values("Date")

#Plot Time Series
df_long[["Month", "Year", "Passengers", "Date"]].head()
plt.figure(figsize=(10,5))
plt.plot(df_long["Date"], df_long["Passengers"], linewidth=2)

#Rolling average
df_long["Rolling_3"] = df_long["Passengers"].rolling(3).mean()
plt.plot(
    df_long["Date"],
    df_long["Rolling_3"],
    linewidth=2,
    linestyle="--",
    label="3-Month Rolling Avg")

#Forecasting
model = LinearRegression()
df_long["t"] = range(len(df_long))
X = df_long[["t"]]
y = df_long["Passengers"]

model.fit(X, y)

#Predict the trend for the Passengers
df_long["Trend"] = model.predict(X)

future_t = np.arange(len(df_long), len(df_long)+12).reshape(-1,1)

forecast = model.predict(future_t)

last_date = df_long["Date"].max()

future_dates = pd.date_range(
    start=last_date,
    periods=13,
    freq="MS")[1:]


#std_dev Forecasting
residuals = y - df_long["Trend"]
std_dev = residuals.std()

upper = forecast + 1*std_dev
lower = forecast - 1*std_dev

#Plotting

#Raw data
plt.plot(
    df_long["Date"],
    df_long["Passengers"],
    label="Actual",
    linewidth=3)


#linear Forecast
plt.plot(
    future_dates,
    forecast,
    linestyle="--",
    label="Forecast (12 months)")

#std_dev band
plt.fill_between(
    future_dates,
    lower,
    upper,
    alpha=0.2,
    label="Confidence Range")

plt.title("Air Passengers Over Time")
plt.xlabel("Date")
plt.ylabel("Passengers")

plt.grid(alpha=0.3)
plt.tight_layout()
plt.show()
plt.savefig("outputs/forecast_chart.png", dpi=200)


