import csv
# import matplotlib
# import matplotlib.pyplot as plt
# import matplotlib.ticker as mticker
# import matplotlib.dates as mdates
import numpy as np

# date,open_price,high,low,close_price,volume,adj_close = np.loadtxt('data/s&p500-weekly-historical-price-data.csv', unpack=True, delimiter=',')

def percent_change(open_price, close_price):
    return ((float(close_price)-float(open_price))/float(open_price))*100.0

# Extract data from s&p500-weekly-historical-price-data.csv
csvfile = open('data/s&p500-weekly-historical-price-data.csv', 'r')
fieldnames = ("date", "open", "high", "low", "close", "volume", "adjusted_close")
reader = csv.DictReader( csvfile, fieldnames)
price_data = []
total_data_points = -1 # to account for fieldnames row in the csv file
for row in reader:
    total_data_points += 1
    if total_data_points > 0:
        row["percent_change"] = percent_change(row["open"], row["close"])
        price_data.append(row);

print(price_data[0])
