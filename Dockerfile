FROM apache/airflow:slim-2.9.0-python3.9

USER root

RUN sudo apt-get update \
  && apt-get install -y --no-install-recommends \
  gcc \
  python3-distutils \
  libpython3.9-dev

USER airflow

COPY --chown=airflow . .

RUN python -m pip install --upgrade pip

RUN pip install --no-cache-dir -r requirements.txt
