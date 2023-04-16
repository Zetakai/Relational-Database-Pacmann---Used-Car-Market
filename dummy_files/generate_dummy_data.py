import csv
from faker import Faker
from tabulate import tabulate
import random
import os
import datetime

def create_csv(table_name, data, headers):
    # Export the table to a CSV file
    file_path = os.path.join(os.getcwd(), "dummy_files/"+table_name+".csv")
    with open(file_path, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(headers)
        writer.writerows(data)

def csv_to_dict(file_name):
    file_path = os.path.join(os.getcwd(), file_name)
    with open(file_path, 'r', encoding='utf-8-sig') as file:
        reader = csv.DictReader(file)
        data = []
        for row in reader:
            data.append(row)
        return data

def create_users(city_table):
    # Create fake data using the Faker library
    fake = Faker('id_ID')  # Use Indonesian locale
    users = []
    for i in range(100):
        user_id=i+1
        name = fake.name()
        phone_number = fake.phone_number()
        city_id = city_table[random.randint(0, 14)]['city_id']
        users.append([user_id,name, phone_number, city_id])

    headers = ["user_id","name", "phone_number", "city_id"]
    # Use tabulate to create a table
    # table = tabulate(users, headers=headers)

    # Print the table to the console
    # print(table)
    create_csv("users",users,headers)

def create_advertisement(car_table):
    # Create fake data using the Faker library
    fake = Faker('id_ID')  # Use Indonesian locale
    advertisement = []
    for i in range(30):
        text= fake.text()
        advertisement_id=i+1
        product_id = car_table[random.randint(1, 49)]['product_id']
        user_id = random.randint(1, 100)
        is_allowed_bid=random.choice([True, False])
        title = text.rsplit()[0]
        description= text
        timestamp_ad=fake.date_time_between(start_date='-2y', end_date='now')
        advertisement.append([advertisement_id,product_id,user_id,is_allowed_bid,title,description,timestamp_ad])

    headers = ['advertisement_id','product_id','user_id','is_allowed_bid','title','description','timestamp_ad']
    # Use tabulate to create a table
    # table = tabulate(advertisement, headers=headers)

    # Print the table to the console
    # print(table)
    create_csv("advertisement",advertisement,headers)

def create_bid():
    # Create fake data using the Faker library
    fake = Faker('id_ID')  # Use Indonesian locale
    bids = []
    for i in range(100):
        bid_id=i+1
        user_id = random.randint(1, 100)
        advertisement_id=random.randint(1, 29)
        timestamp_bid=fake.date_time_between(start_date='-2y', end_date='now')
        status_bid= random.choice(["Succeed","Rejected","Pending", "Canceled"])
        price_bid=random.randint(60000000, 415000000)
        bids.append([bid_id,user_id,advertisement_id,price_bid,status_bid,timestamp_bid])

    headers = ['bid_id','user_id','advertisement_id','price_bid','status_bid','timestamp_bid']
    # Use tabulate to create a table
    # table = tabulate(bids, headers=headers)

    # Print the table to the console
    # print(table)
    create_csv("bid",bids,headers)

# create_users(csv_to_dict('dummy_files/city.csv'))
# create_advertisement(csv_to_dict('dummy_files/car_product.csv'))
create_bid()