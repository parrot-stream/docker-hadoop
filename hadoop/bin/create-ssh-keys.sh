rm /etc/ssh/*key* 2>/dev/null
rm /root/.ssh/id_rsa 2>/dev/null
rm /home/user/hdfs/.ssh/id_rsa 2>/dev/null

ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

#ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa

cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

ssh-keygen -q -N "" -t dsa -P '' -f ~/.ssh/id_dsa
cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

