from datetime import datetime
from airflow import DAG
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators import MyFirstOperator, MyFirstSensor

def print_hello():
    return 'Hello world MM!'

dag = DAG('hello_world', description='Simple tutorial DAG',
          schedule_interval='0 12 * * *',
          start_date=datetime(2020, 5, 1), catchup=False)

dummy_operator = DummyOperator(task_id='dummy_task', retries=3, dag=dag)

sensor_task = MyFirstSensor(task_id='my_sensor_task', poke_interval=30, dag=dag, mode='reschedule')

hello_operator = MyFirstOperator(my_operator_param='This is a test', task_id='my_first_operator_task' , dag=dag)

dummy_operator >> sensor_task >> hello_operator