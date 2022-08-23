#!/usr/bin/env python3

from Historic_Crypto import HistoricalData
import pandas as pd 
from scipy.stats import pearsonr
import matplotlib.pyplot as plt 
import matplotlib.colors as col 
from matplotlib import cm
import numpy as np 

# the price frequency in seconds: 21600 = 6 hour price data, 86400 = daily price data
frequency = 21600
# The beginning of the period for which prices will be retrieved
from_date = '2021-01-01-00-00'
# The currency price pairs for which the data will be retrieved
coinlist = ['ETH-USD', 'BTC-USD']

# Query the data
for i in range(len(coinlist)):
    coinname = coinlist[i]
    pricedata = HistoricalData(coinname, frequency, from_date).retrieve_data()
    pricedf = pricedata[['close', 'low', 'high']]
    if i == 0:
        df = pd.DataFrame(pricedf.copy())
    else:
        df = pd.merge(left=df, right=pricedf, how='left', left_index=True, right_index=True)   
    df.rename(columns={"close": "close-" + coinname}, inplace=True)
    df.rename(columns={"low": "low-" + coinname}, inplace=True)
    df.rename(columns={"high": "high-" + coinname}, inplace=True)

# Create a Price Chart on BTC and ETH
x = df.index
fig, ax1 = plt.subplots(figsize=(16, 8), sharex=False)

# Price Chart for BTC-USD Close
color = 'tab:blue'
y = df['close-BTC-USD']
ax1.set_xlabel('time (s)')
ax1.set_ylabel('BTC-Close in $', color=color, fontsize=18)
ax1.plot(x, y, color=color)
ax1.tick_params(axis='y', labelcolor=color)
ax1.text(0.02, 0.95, 'BTC-USD',  transform=ax1.transAxes, color=color, fontsize=16)

# Price Chart for ETH-USD Close
color = 'tab:red'
y = df['close-ETH-USD']
ax2 = ax1.twinx()  # instantiate a second axes that shares the same x-axis
ax2.set_ylabel('ETH-Close in $', color=color, fontsize=18)  # we already handled the x-label with ax1
ax2.plot(x, y, color=color)
ax2.tick_params(axis='y', labelcolor=color)
ax2.text(0.02, 0.9, 'ETH-USD',  transform=ax2.transAxes, color=color, fontsize=16)
#ax2.set_ylim(0, y.max())

plt.show()
