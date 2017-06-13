#!/bin/bash

/opt/docker/wait-for-it.sh zookeeper:2181 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n--------------------------------------------"
    echo -e "      Zookeeper not ready! Exiting..."
    echo -e "--------------------------------------------"
    exit $rc
fi

/opt/docker/start-hdfs.sh
/opt/docker/start-yarn.sh

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following Hadoop Web UIs:"
echo -e ""
echo -e "Hadoop - NameNode:			http://localhost:50070"
echo -e "Hadoop - DataNode:			http://localhost:50075"
echo -e "Hadoop - YARN Node Manager:		http://localhost:8042"
echo -e "Hadoop - YARN Resource Manager:	http://localhost:8088"
echo -e "Hadoop - YARN Application History:	http://localhost:8188"
echo -e "Hadoop - MapReduce Job History:	http://localhost:19888/jobhistory"
echo -e "\nMantainer:   Matteo Capitanio <matteo.capitanio@gmail.com>"
echo -e "--------------------------------------------------------------------------------\n\n"
