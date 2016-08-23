#!/bin/bash

rm /tmp/*.pid 2> /dev/null

supervisorctl start sshd
supervisorctl start hdfs
supervisorctl start resourcemanager
supervisorctl start nodemanager
supervisorctl start timelineserver
supervisorctl start historyserver

ip=`awk 'END{print $1}' /etc/hosts`

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e " You can now access to the following Hadoop Web GUI:"
echo -e ""
echo -e "Hadoop - NameNode:			http://$ip:50070"
echo -e "Hadoop - DataNode:			http://$ip:50075"
echo -e "Hadoop - YARN Node Manager:		http://$ip:8042"
echo -e "Hadoop - YARN Resource Manager:		http://$ip:8088"
echo -e "Hadoop - YARN Application History:	http://$ip:8188"
echo -e "Hadoop - MapReduce Job History:		http://$ip:19888/jobhistory"
echo -e "--------------------------------------------------------------------------------\n\n"

