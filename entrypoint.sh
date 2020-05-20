#!/bin/bash

case "$1" in
    webserver)
        echo 'initdb'
        airflow initdb

        echo 'start webserver'
        exec airflow webserver
        ;;
    worker|scheduler)
        echo 'start scheduler'
        exec airflow "$@"
        ;;
    *)
        exec "$@"
        ;;
esac