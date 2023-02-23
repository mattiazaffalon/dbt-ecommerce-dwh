import pandas as pd
import random
import string

# Definizione dei dati casuali per la tabella customer
customer_cd = [i+1 for i in range(100)]
surname = [''.join(random.choices(string.ascii_uppercase, k=10)) for i in range(100)]
name = [''.join(random.choices(string.ascii_uppercase, k=10)) for i in range(100)]
address = [''.join(random.choices(string.ascii_uppercase + string.digits, k=20)) for i in range(100)]
city = [''.join(random.choices(string.ascii_uppercase, k=10)) for i in range(100)]
region = [''.join(random.choices(string.ascii_uppercase, k=10)) for i in range(100)]
country = [''.join(random.choices(string.ascii_uppercase, k=10)) for i in range(100)]
postal_code = [random.randint(10000, 99999) for i in range(100)]
email = [''.join(random.choices(string.ascii_lowercase + string.digits, k=10)) + '@' + ''.join(random.choices(string.ascii_lowercase + string.digits, k=5)) + '.com' for i in range(100)]

# Creazione del dataframe per la tabella customer
customers = pd.DataFrame({
    'customer_cd': customer_cd,
    'surname': surname,
    'name': name,
    'address': address,
    'city': city,
    'region': region,
    'country': country,
    'postal_code': postal_code,
    'email': email
})

# Definizione dei dati casuali per la tabella products_catalog
product_cd = [i+1 for i in range(50)]
name = [''.join(random.choices(string.ascii_uppercase, k=10)) for i in range(50)]
description = [''.join(random.choices(string.ascii_uppercase + string.digits, k=20)) for i in range(50)]
category = ['Category ' + str(random.randint(1, 5)) for i in range(50)]
unit_price = [round(random.uniform(10, 1000), 2) for i in range(50)]

# Creazione del dataframe per la tabella products_catalog
products_catalog = pd.DataFrame({
    'product_cd': product_cd,
    'name': name,
    'description': description,
    'category': category,
    'unit_price': unit_price
})

# Definizione dei dati casuali per la tabella billing_orders
n_rows = 10000
order_num = [i+1 for i in range(n_rows)]
datetime = pd.date_range(start='2022-01-01', end='2022-01-01', periods=n_rows).round('1s')
customer_cd = [random.randint(1, 100) for i in range(n_rows)]
product_cd = [random.randint(1, 50) for i in range(n_rows)]
unit_price = [round(random.uniform(1, 100), 2) for i in range(n_rows)]
quantity = [random.randint(1, 5) for i in range(n_rows)]
discount = [round(random.uniform(0, 0.5), 2) for i in range(n_rows)]
total_amount = [round(unit_price[i] * quantity[i] * (1 - discount[i]), 2) for i in range(n_rows)]

# Creazione del dataframe per la tabella billing_orders
billing_orders = pd.DataFrame({
    'order_num': order_num,
    'datetime': datetime,
    'customer_cd': customer_cd,
    'product_cd': product_cd,
    'unit_price': unit_price,
    'quantity': quantity,
    'discount': discount,
    'total_amount': total_amount
})

def generate_csv(df, dataset_name, datesuffix):
    df.to_csv(f"generated/{dataset_name}_{datesuffix}.csv", index=False, sep=',')

generate_csv(billing_orders, 'billing_orders_d', '20220101')
generate_csv(products_catalog, 'products_catalog_d', '20220101')
generate_csv(customers, 'customers_d', '20220101')