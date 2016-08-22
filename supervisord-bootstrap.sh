#!/bin/bash

rm /tmp/*.pid 2> /dev/null

supervisorctl start sshd
supervisorctl start hdfs
supervisorctl start resourcemanager
sleep 5
supervisorctl start nodemanager
sleep 5
supervisorctl start timelineserver
supervisorctl start historyserver

ip=`awk 'END{print $1}' /etc/hosts`

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e " You can now access to the following Hadoop Web GUI:"
echo -e ""
echo -e "\tHadoop - NameNode:			http://$ip:50070"
echo -e "\tHadoop - YARN Node Manager:		http://$ip:8042"
echo -e "\tHadoop - YARN Resource Manager:	http://$ip:8088"
echo -e "\tHadoop - YARN Application History:	http://$ip:8188"
echo -e "\tHadoop - MapReduce Job History:	http://$ip:19888/jobhistory"
echo -e "--------------------------------------------------------------------------------\n\n"

