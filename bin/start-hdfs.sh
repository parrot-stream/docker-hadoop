#!/bin/bash

echo -e "\n---------------------------------------"

if [[ ! -e /var/lib/hadoop-hdfs/cache/hdfs/dfs/name/current ]]; then
    	echo -e	"Initiating HDFS NameNode..."
	/etc/init.d/hadoop-hdfs-namenode init
	rc=$?
    	if [ $rc -ne 0 ]; then
	    	echo -e	"HDFS initiation ERROR!"
    	else
        	echo -e	"HDFS successfully initiaded!"
    	fi
fi

echo -e	"Starting NameNode..."
supervisorctl start hdfs-namenode
echo -e	"Starting DataNode..."
supervisorctl start hdfs-datanode

./wait-for-it.sh localhost:8020 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "     HDFS not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

sudo -E -u hdfs hdfs dfs -mkdir -p /user/hive/warehouse
sudo -E -u hdfs hdfs dfs -mkdir -p /user/hue
sudo -E -u hdfs hdfs dfs -mkdir -p /user/impala
sudo -E -u hdfs hdfs dfs -mkdir -p /tmp
sudo -E -u hdfs hdfs dfs -chmod -R 777 /
