import requests
from datetime import datetime
from airflow import DAG
from airflow.operators.bash import BashOperator
import os

dag_id = os.path.basename(__file__).split(".")[0]

dag = DAG(
    dag_id,
    schedule_interval=None,
    start_date=datetime(2024, 5, 16),
)

print_ds_date = BashOperator(
    task_id="print_ds_date",
    bash_command="echo {{ ds }}",
    dag=dag
)

print_execution_date = BashOperator(
    task_id="print_logical_date",
    bash_command="echo {{ execution_date.in_timezone('Asia/Jakarta').strftime('%Y-%m-%d') }}",
    dag=dag
)

[print_ds_date, print_execution_date]
