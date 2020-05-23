from airflow import DAG
from datetime import datetime
from airflow.operators.postgres_operator import PostgresOperator


dag = DAG('db_setup', description='DB setup', schedule_interval='0 12 * * *', start_date=datetime(2020,5,19))

create_table = PostgresOperator(task_id='create_table', database='data', sql='''
CREATE TABLE users(
    id INTEGER NOT NULL,
    name VARCHAR(50) NOT NULL
);
''', dag=dag)


insert_row = PostgresOperator(task_id='insert_row', database='data',
 sql='INSERT INTO users VALUES(%s, %s)', parameters=(1, 'michal'), dag=dag)

create_table >> insert_row