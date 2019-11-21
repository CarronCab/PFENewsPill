import csv
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from datetime import timedelta, date, datetime

#########################################################################
# Read the CSV                                                          #
# id, idstock, date_add, date_message, iduser, idST, content, sentiment #
#########################################################################
data = pd.read_csv('../ListMessagesCSV.csv', encoding="utf8")
df = pd.DataFrame(data, columns=['id', 'date_add', 'content'])

#######################################################
# date parser from string and  remove seconds minutes #
#######################################################
df['date_add'] = pd.to_datetime(df['date_add'])
df = df.assign(date_add=df.date_add.dt.round('T'))

##################################################################
# Select on the content column the ones that contains our ticker #
##################################################################
df = df[df['content'].str.contains("\\$DIS ")]

# set the date_add column as the index first
df = df.set_index(['date_add'])

# select rows by date
startDate = '2019-11-07 16'
endDate = '2019-11-08 02'
dfZoomed = df.loc[startDate: endDate]

countZoomed = dfZoomed.pivot_table(index=['date_add'], aggfunc='size').cumsum()
count = df.pivot_table(index=['date_add'], aggfunc='size').cumsum()
print(count)

plt.figure('Nombre de tweets cumulés')
count.plot.area()

plt.figure('Nombre de tweets cumulés entre ' + startDate + 'h et ' + endDate + 'h')
countZoomed.plot.area()
plt.show()

'''
df.plot(kind="line")
plt.ylabel('nombre de ST')
plt.xlabel('Dates')
plt.show()
'''

'''
###########################################
# Compute the number of days of the range #
###########################################

def dateRange(start_date, end_date):
    for n in range(int((end_date - start_date).days)):
        yield start_date + timedelta(n)


start_date = date(2019, 8, 1)
end_date = date(2019, 11, 1)

days = []

for single_date in dateRange(start_date, end_date):
    days.append(single_date)
'''

'''
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
