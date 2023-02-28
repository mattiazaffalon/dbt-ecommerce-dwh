#!/bin/bash

if [ "$#" -ne "4" ]; then
    echo "Launch script with parameters: CREDENTIALS_PATH, BQ_PROJECT_ID, BQ_DATASET, BQ_LOCATION"
    exit 1
fi

cp $1 auth.json

sudo docker build \
    --build-arg CREDENTIALS_PATH=auth.json \
    --build-arg BQ_PROJECT_ID=$2 \
    --build-arg BQ_DATASET=$3 \
    --build-arg BQ_LOCATION=$4 \
    -t dbt-ecommerce-dwh:latest .

rm -rf auth.json