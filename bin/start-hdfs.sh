#!/bin/bash

if [[ ! -e /var/lib/hadoop-hdfs/cache/hdfs/dfs/name/current ]]; then
	/etc/init.d/hadoop-hdfs-namenode init
fi
supervisorctl start hdfs-namenode
supervisorctl start hdfs-datanode

./wait-for-it.sh hadoop:8020 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "     HDFS not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

sudo -u hdfs hdfs dfs -chmod -R 777 /user

#sudo -u hdfs hdfs dfs -mkdir -p /user/hive/warehouse
#sudo -u hdfs hdfs dfs -chmod -R 777 /user/hive
#sudo -u hdfs hdfs dfs -chown hdfs:supergroup /
#sudo -u hdfs hdfs dfs -mkdir -p /tmp/hive/hive


#sudo -u hdfs hdfs dfs -chmod -R 777 /tmp
#sudo -u hdfs hdfs dfs -chown -R hdfs:supergroup /tmp

#sudo -u hdfs hdfs dfs -chmod -R 777 /user
#sudo -u hdfs hdfs dfs -chown -R hdfs:supergroup /user
#sudo -u hdfs hdfs dfs -chown -R hive:hive /user/hive
