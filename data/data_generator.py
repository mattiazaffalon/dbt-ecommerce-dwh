import pandas as pd
import random
import string
import datetime
import argparse

def _write_csv(df, dataset_name, refdate):
    dtsuffix = refdate.strftime("%Y%m%d")
    df.to_csv(f"generated/{dataset_name}_{dtsuffix}.csv", index=False, sep=',', date_format='%Y-%m-%d %H:%M:%S')

def _generate_customers(howmany: int, refdate: datetime.date):
    customer_cd = [i+1 for i in range(howmany)]
    surname = [''.join(random.choices(string.ascii_uppercase, k=10)) for i in range(howmany)]
    name = [''.join(random.choices(string.ascii_uppercase, k=10)) for i in range(howmany)]
    address = [''.join(random.choices(string.ascii_uppercase + string.digits, k=20)) for i in range(howmany)]
    city = [''.join(random.choices(string.ascii_uppercase, k=10)) for i in range(howmany)]
    region = [''.join(random.choices(string.ascii_uppercase, k=10)) for i in range(howmany)]
    country = [''.join(random.choices(string.ascii_uppercase, k=10)) for i in range(howmany)]
    postal_code = [random.randint(10000, 99999) for i in range(howmany)]
    email = [''.join(random.choices(string.ascii_lowercase + string.digits, k=10)) + '@' + ''.join(random.choices(string.ascii_lowercase + string.digits, k=5)) + '.com' for i in range(howmany)]
    
    dateseed = datetime.datetime(refdate.year, refdate.month, refdate.day, 0, 0, 0)
    updated_at = [dateseed + datetime.timedelta(seconds=random.randrange(86400)) for i in range(howmany)]

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
        'email': email,
        'updated_at': updated_at
    })

    _write_csv(customers, 'customers_d', refdate)


def _generate_products(howmany: int, refdate: datetime.date):
    product_cd = [i+1 for i in range(howmany)]
    name = [''.join(random.choices(string.ascii_uppercase, k=10)) for i in range(howmany)]
    description = [''.join(random.choices(string.ascii_uppercase + string.digits, k=20)) for i in range(howmany)]
    category = ['Category ' + str(random.randint(1, 5)) for i in range(howmany)]
    unit_price = [round(random.uniform(10, 1000), 2) for i in range(howmany)]

    dateseed = datetime.datetime(refdate.year, refdate.month, refdate.day, 0, 0, 0)
    created_at = [dateseed + datetime.timedelta(seconds=random.randrange(86400)) for i in range(howmany)]

    # Creazione del dataframe per la tabella products_catalog
    products_catalog = pd.DataFrame({
        'product_cd': product_cd,
        'name': name,
        'description': description,
        'category': category,
        'unit_price': unit_price,
        'created_at': created_at
    })

    _write_csv(products_catalog, 'products_f', refdate)

def _generate_billing_orders(howmany: int, refdate: datetime.date):
    order_num = [i+1 for i in range(howmany)]
    customer_cd = [random.randint(1, 100) for i in range(howmany)]
    product_cd = [random.randint(1, 50) for i in range(howmany)]
    unit_price = [round(random.uniform(1, 100), 2) for i in range(howmany)]
    quantity = [random.randint(1, 5) for i in range(howmany)]
    discount = [round(random.uniform(0, 0.5), 2) for i in range(howmany)]
    total_amount = [round(unit_price[i] * quantity[i] * (1 - discount[i]), 2) for i in range(howmany)]
    
    dateseed = datetime.datetime(refdate.year, refdate.month, refdate.day, 0, 0, 0)
    created_at = [dateseed + datetime.timedelta(seconds=random.randrange(86400)) for i in range(howmany)]

    # Creazione del dataframe per la tabella billing_orders
    billing_orders = pd.DataFrame({
        'order_num': order_num,
        'customer_cd': customer_cd,
        'product_cd': product_cd,
        'unit_price': unit_price,
        'quantity': quantity,
        'discount': discount,
        'total_amount': total_amount,
        'created_at': created_at
    })

    _write_csv(billing_orders, 'billing_orders_d', refdate)


if __name__ == '__main__':

    parser = argparse.ArgumentParser(description='Generate seed for dwh source data')

    parser.add_argument('--refdate', type=datetime.date, help='Reference date of data', default=datetime.date.today())
    parser.add_argument('--numorders', type=int, help='How many orders', default=1000)
    parser.add_argument('--numproducts', type=int, help='How many products', default=50)
    parser.add_argument('--numcustomers', type=int, help='How many customers', default=100)

    args = parser.parse_args()

    refdate = args.refdate
    numorders = args.numorders
    numproducts = args.numproducts
    numcustomers = args.numcustomers

    print(f'Generating {numcustomers} customers, {numproducts} products, {numorders} orders for reference date: {refdate}')

    _generate_customers(numcustomers, refdate)
    _generate_products(numproducts, refdate)
    _generate_billing_orders(numorders, refdate)
    


