import csv
import numpy as np
import pandas as pd
from datetime import timedelta, date

# Read the CSV
# id, idstock, date_add, date_message, iduser, idST, content, sentiment
data = pd.read_csv('../ListMessagesCSV.csv', encoding="utf8")
df = pd.DataFrame(data, columns=['id', 'idstock', 'date_add', 'date_message', 'iduser', 'idST', 'content', 'sentiment'])

# date parser from string
df['date_add'] = pd.to_datetime(df['date_add'])
df['date_add'] = df['date_add'].dt.date
# Select on the content column the ones that contains our ticker
df = df[df['content'].str.contains("\\$AAPL ")]

print(df)
print(df['date_add'])
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