#!/bin/bash

sudo docker stop dbt > /dev/null 2>&1
sudo docker rm dbt > /dev/null 2>&1

sudo docker run -t -d --name dbt dbt-ecommerce-dwh:latest