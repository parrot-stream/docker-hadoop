#!/bin/bash

rm /etc/ssh/*key*
rm /root/.ssh/id_rsa

ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key; \
ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key; \
ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key; \
ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key; \
ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa; \
cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

rm /tmp/*.pid 2> /dev/null

wait-for-it.sh zookeeper:2181 -t 120

rc=$?
if [ $rc -ne 0 ]; then
    echo "Zookeeper not ready! Exiting..."
	exit $rc
fi

supervisorctl start sshd
supervisorctl start hdfs
supervisorctl start resourcemanager
supervisorctl start nodemanager
supervisorctl start timelineserver
supervisorctl start historyserver

hdfs dfs -chown hdfs:supergroup /

ip=`awk 'END{print $1}' /etc/hosts`

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following Hadoop Web UIs:"
echo -e ""
echo -e "Hadoop - NameNode:			http://$ip:50070"
echo -e "Hadoop - DataNode:			http://$ip:50075"
echo -e "Hadoop - YARN Node Manager:		http://$ip:8042"
echo -e "Hadoop - YARN Resource Manager:		http://$ip:8088"
echo -e "Hadoop - YARN Application History:	http://$ip:8188"
echo -e "Hadoop - MapReduce Job History:		http://$ip:19888/jobhistory"
echo -e "--------------------------------------------------------------------------------\n\n"
