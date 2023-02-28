FROM ghcr.io/dbt-labs/dbt-bigquery:1.3.latest

# define in docker build
ARG BQ_PROJECT_ID
ARG BQ_DATASET
ARG CREDENTIALS_PATH
ARG DBT_PROJECT_DIR .
ARG BQ_LOCATION

ENV DBT_PROJECT_DIR=$DBT_PROJECT_DIR
ENV BQ_PROJECT_ID=$BQ_PROJECT_ID
ENV BQ_DATASET=$BQ_DATASET
ENV BQ_LOCATION=$BQ_LOCATION

# default env values, can be overridden
ENV DBT_PROFILES_DIR=/usr/app/dbt/ci_profiles/
ENV GOOGLE_APPLICATION_CREDENTIALS=/usr/app/dbt/auth/gcp-service-account.json
ENV TARGET=dev

USER root

# Copy dbt project in the docker image to build
COPY $DBT_PROJECT_DIR /usr/app/dbt
COPY $CREDENTIALS_PATH /usr/app/dbt/auth/gcp-service-account.json

# Use root to avoid permission issues
USER root

RUN dbt deps
RUN dbt debug --target=$TARGET

ENTRYPOINT ["/bin/sh", "-c", "dbt deps && dbt run-operation stage_external_sources && dbt snapshot && dbt run && dbt test"]