ARG BASE_IMAGE=python:3.8-buster
FROM $BASE_IMAGE as common

# set GCP credential
COPY conf/local/gcp_credential.json /tmp/gcp_credential.json
ENV GOOGLE_APPLICATION_CREDENTIALS /tmp/gcp_credential.json

# install project requirements
COPY src/requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt && rm -f /tmp/requirements.txt

FROM common as kedro

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE 1
RUN apt-get update -y && \
  curl -fsSL https://deb.nodesource.com/setup_15.x | bash - && \
  apt-get install -y --no-install-recommends nodejs && \
  npm install -sg electron@6.1.4 orca

# add kedro user
ARG KEDRO_UID=999
ARG KEDRO_GID=0
RUN groupadd -f -g ${KEDRO_GID} kedro_group && \
  useradd -d /home/kedro -s /bin/bash -g ${KEDRO_GID} -u ${KEDRO_UID} kedro

# copy the whole project except what is in .dockerignore
WORKDIR /home/kedro
COPY . .
RUN chown -R kedro:${KEDRO_GID} /home/kedro
USER kedro
RUN chmod -R a+w /home/kedro

FROM common as mlflow

# add mlflow user
ARG MLFLOW_UID=999
ARG MLFLOW_GID=0
RUN groupadd -f -g ${MLFLOW_GID} mlflow_group && \
  useradd -d /home/mlflow -s /bin/bash -g ${MLFLOW_GID} -u ${MLFLOW_UID} mlflow

# copy the whole project except what is in .dockerignore
WORKDIR /home/mlflow
RUN chown -R mlflow:${MLFLOW_GID} /home/mlflow
USER mlflow
RUN chmod -R a+w /home/mlflow
