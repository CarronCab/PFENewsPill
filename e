import csv
import os
import numpy as np
import pandas as pd
from datetime import timedelta, date
import numpy as np
import matplotlib.pyplot as plt

# Read the CSV
# id, name, ticker, exchange
data = pd.read_csv('../ListStocks.csv')
df = pd.DataFrame(data, columns=['id', 'name', 'ticker'])

cpt = 1

# Get the company from the user
while (cpt == 1):
    # Retreiving and shaping the company's name to smth like this "Abcdef"
    print('What company do you want to watch ?')
    company = input()
    # company = input().casefold()
    # company = company[:1].upper() + company[1:]

    # Get the company's ticker
    cdf = df[df['name'] == company]

    if cdf.shape[0] == 0:  # If there is not a company with that name
        print('Can\'t find anything about ' + company + ' , try with another value !')
    else:  # If there is a company with this name
        cpt = 0
        ticker = cdf['ticker'].item()
        print('You are now watching ' + company + ' with the ticker ' + ticker)

# id, idstock, date_add, date_message, iduser, idST, content, sentiment
data = pd.read_csv('../ListMessagesCSV.csv', encoding="utf8")
df = pd.DataFrame(data, columns=['id', 'date_add', 'content'])

# date parser from string
df['date_add'] = pd.to_datetime(df['date_add'])
# df['date_add'] = df['date_add'].dt.date -> par jour
f = df.assign(date_add=df.date_add.dt.round('H'))  # par heure = H / par minute = T
# Select on the content column the ones that contains our ticker
df = df[df['content'].str.contains("\\$" + ticker)]

print(df)
print(df['date_add'])

# set the date_add column as the index first
df = df.set_index(['date_add'])

# select rows by date
startDate = '2019-11-07 16'
endDate = '2019-11-08 02'
dfZoomed = df.loc[startDate: endDate]

# Cumulative count of the tweets on a range
plt.figure('Nombre de tweets cumulés concernant ' + company + ' entre ' + startDate + 'h et ' + endDate + 'h')
figManager = plt.get_current_fig_manager()
figManager.window.showMaximized()
countZoomed = dfZoomed.pivot_table(index=['date_add'], aggfunc='size').cumsum()
countZoomed.plot.area()

# Cumulative count of the tweets per date (hours)
plt.figure('Nombre de tweets cumulés concernant ' + company + ' par heures')
figManager = plt.get_current_fig_manager()
figManager.window.showMaximized()
count = df.pivot_table(index=['date_add'], aggfunc='size').cumsum()
count.plot.area()

# Count the tweets per date (hours)
df = df.pivot_table(index=['date_add'], aggfunc='size')

print(df)

# Check if the file already exists : if it does, removes it
if os.path.exists('../csv/tweets.csv'):
    if os.stat('../csv/tweets.csv').st_size != 0:
        os.remove('../csv/tweets.csv')

# Write in the csv
df.to_csv('../csv/tweets.csv', header=False)

# Properties
plt.figure('Nombre de tweets concernant ' + company + ' par heures')
df.plot(kind='line')

plt.title('Nombre de tweets concernant ' + company + ' par heures')
plt.xlabel('Date')
plt.ylabel('Nombre de tweets')

# Force FullScreen
figManager = plt.get_current_fig_manager()
figManager.window.showMaximized()
plt.show()



'''labels = df['date_add']
women_means = df['size']
print(labels)
# Create the plot
#labels = ['G1', 'G2', 'G3', 'G4', 'G5'] # Jours
#labels = []
#women_means = [25, 32, 34, 20, 25]
x = np.arange(len(labels))  # the label locations
width = 0.3  # the width of the bars
fig, ax = plt.subplots()
rect = ax.bar(x, women_means, width)
# Add some text for labels, title and custom x-axis tick labels, etc.
ax.set_ylabel('Nombre de tweets')
ax.set_title('Nombre de tweets par jour')
ax.set_xticks(x)
ax.set_xticklabels(labels) #Jours
fig.tight_layout()
plt.show()'''

'''
def dateRange(start_date, end_date):
    for n in range(int((end_date - start_date).days)):
        yield start_date + timedelta(n)
start_date = date(2019, 8, 1)
end_date = date(2019, 11, 1)
nbrSt = len(df['date_add'])
day = 0
for single_date in dateRange(start_date, end_date):
    day = day + 1
    #print(single_date.strftime("%Y-%m-%d"))
tab = [92]
actual_day = 0
for i in range(day):
    tab[i] = 0
    print(tab[i])
#for single_date in dateRange(start_date, end_date):
    #tab[actual_day].append(1)
    #actual_day = actual_day + 1
# print(df['date_add'])
'''
