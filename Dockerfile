FROM centos

MAINTAINER Matteo Capitanio <matteo.capitanio@gmail.com>

USER root

RUN yum update -y
RUN yum install -y wget python-setuptools java-1.8.0-openjdk-devel sudo curl vim
RUN easy_install supervisor
ADD cloudera-cdh5.repo /etc/yum.repos.d/
RUN rpm --import https://archive.cloudera.com/cdh5/redhat/5/x86_64/cdh/RPM-GPG-KEY-cloudera
RUN yum install -y hadoop-hdfs-namenode hadoop-hdfs-datanode hadoop-yarn-resourcemanager hadoop-yarn-nodemanager hadoop-mapreduce-historyserver

RUN mkdir -p /var/run/hdfs-sockets; \
    chown hdfs.hadoop /var/run/hdfs-sockets
RUN mkdir -p /data/dn/
RUN chown hdfs.hadoop /data/dn

ADD etc/supervisord.conf /etc/
ADD etc/hadoop/conf/core-site.xml /etc/hadoop/conf/
ADD etc/hadoop/conf/hdfs-site.xml /etc/hadoop/conf/
ADD etc/hadoop/conf/mapred-site.xml /etc/hadoop/conf/

WORKDIR /

# Various helper scripts
ADD bin/start-hdfs.sh ./
ADD bin/start-yarn.sh ./
ADD bin/supervisord-bootstrap.sh ./
ADD bin/wait-for-it.sh ./
RUN chmod +x ./*.sh
RUN chown mapred:mapred /var/log/hadoop-mapreduce

EXPOSE 50010 50020 50070 50075 50090 50091 50100 50105 50475 50470 8020 8485 8480 8481
EXPOSE 50030 50060 13562 10020 19888
EXPOSE 8030 8031 8032 8040 8042 8046 8047 8088 8090 8188 8190 8788 10200

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
