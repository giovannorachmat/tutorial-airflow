FROM apache/airflow:slim-2.9.0

ENV AIRFLOW_HOME=/opt/airflow
ENV DBT_PROJECT_DIR=${AIRFLOW_HOME}/dbt/dbt_tutorial
ENV DBT_PROFILES_DIR=${DBT_PROJECT_DIR}

USER root

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  gcc \
  python3-distutils

USER airflow

COPY --chown=airflow . ${AIRFLOW_HOME}

RUN python -m pip install --no-cache-dir --upgrade pip==24.0 && \ 
  pip install --no-cache-dir -r ${AIRFLOW_HOME}/requirements.txt

RUN cd ${DBT_PROJECT_DIR} && dbt deps
