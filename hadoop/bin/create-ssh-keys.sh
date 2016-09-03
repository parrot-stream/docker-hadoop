#!/bin/bash

#rm -f /etc/ssh/*key

#ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
#ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
#ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
#ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

#rm -f ~/.ssh/id_dsa
#ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
#cat ~/.ssh/id_dsa.pub > ~/.ssh/authorized_keys
#chmod 0600 ~/.ssh/authorized_keys

#mkdir -p /home/hdfs/.ssh
#rm -f /home/hdfs/.ssh/id_dsa
#cp ~/.ssh/id_dsa /home/hdfs/.ssh/id_dsa
#cp ~/.ssh/id_dsa.pub /home/hdfs/.ssh/id_dsa.pub
#cat /home/hdfs/.ssh/id_dsa.pub > /home/hdfs/.ssh/authorized_keys
#chown -R hdfs:hdfs /home/hdfs/.ssh
#chmod 600 /home/hdfs/.ssh/authorized_keys


#runuser -m -u hdfs "ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa"
#runuser -m -u hdfs 'cat ~/.ssh/id_dsa.pub > ~/.ssh/authorized_keys'
#runuser -m -u hdfs 'chmod 0600 ~/.ssh/authorized_keys'

ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
cat ~/.ssh/id_dsa.pub > ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
