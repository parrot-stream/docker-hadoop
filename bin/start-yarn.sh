#!/bin/bash

supervisorctl start yarn-nodemanager
./wait-for-it.sh localhost:8042 -t 60
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n--------------------------------------------"
    echo -e "YARN Node Manager not ready! Exiting..."
    echo -e "--------------------------------------------"
    exit $rc
fi

supervisorctl start yarn-resourcemanager
./wait-for-it.sh localhost:8088 -t 60
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n--------------------------------------------"
    echo -e "YARN Resource Manager not ready! Exiting..."
    echo -e "--------------------------------------------"
    exit $rc
fi

supervisorctl start mapreduce-historyserver
./wait-for-it.sh localhost:19888 -t 60
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n--------------------------------------------"
    echo -e "MapReduce Job History not ready! Exiting..."
    echo -e "--------------------------------------------"
    exit $rc
fi

supervisorctl start yarn-timelineserver
./wait-for-it.sh localhost:8188 -t 60
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n--------------------------------------------"
    echo -e "       YARN Application History..."
    echo -e "--------------------------------------------"
    exit $rc
fi
