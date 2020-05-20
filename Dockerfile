FROM python:3.7-stretch
WORKDIR /app
ENV AIRFLOW_HOME /app
ADD entrypoint.sh .
ADD requirements.txt .
RUN pip install -r requirements.txt
ADD dags ./dags
ADD plugins ./plugins

ENTRYPOINT [ "/app/entrypoint.sh" ]
CMD [ "webserver" ]