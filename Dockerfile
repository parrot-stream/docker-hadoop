FROM parrotstream/centos-openjdk:8

ENV HADOOP_VER 3.0.3

MAINTAINER Matteo Capitanio <matteo.capitanio@gmail.com>

USER root

ENV HDFS_NAMENODE_USER "root"
ENV HDFS_DATANODE_USER "root"
ENV HDFS_SECONDARYNAMENODE_USER "root"
ENV YARN_RESOURCEMANAGER_USER "root"
ENV YARN_NODEMANAGER_USER "root"
ENV HADOOP_HOME /opt/hadoop
ENV HADOOP_COMMON_HOME $HADOOP_HOME
ENV HADOOP_COMMON_LIB_NATIVE $HADOOP_HOME/lib/native
ENV HADOOP_CONF_DIR $HADOOP_HOME/etc/hadoop
ENV HADOOP_LOG_DIR $HADOOP_HOME/logs

ENV PATH $HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

# Install needed packages
RUN yum update -y
RUN yum install -y which openssh-clients openssh-server openssl
RUN yum clean all

WORKDIR /opt/docker

RUN useradd -p $(echo "hdfs" | openssl passwd -1 -stdin) hdfs; \
    groupadd supergroup; \
    usermod -a -G supergroup hdfs;

# Apache Hadoop
RUN wget http://mirror.nohup.it/apache/hadoop/common/hadoop-$HADOOP_VER/hadoop-$HADOOP_VER.tar.gz
RUN tar -xvf hadoop-$HADOOP_VER.tar.gz -C ..; \
    mv ../hadoop-$HADOOP_VER $HADOOP_HOME

ADD ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config; \
    chown root:root /root/.ssh/config

COPY hadoop $HADOOP_HOME
#RUN cat $HADOOP_HOME/etc/hadoop/hadoop-env.sh
COPY ./etc /etc
RUN chmod +x $HADOOP_HOME/etc/hadoop/*.sh
RUN chmod +x $HADOOP_HOME/bin/*.sh

RUN rm -rf /hdfs; \
    mkdir -p /hdfs; \
    chown -R hdfs:hdfs /hdfs; \
    chown -R hdfs:hdfs $HADOOP_HOME

#USER hdfs
RUN mkdir -p $HADOOP_HOME/logs; \
    hdfs namenode -format

# hdfs-default.xml ports
EXPOSE 9871 9870 9820 9869 9868 9867 9866 9865 9864
# mapred-default.xml ports
EXPOSE 50030 50060 13562 10020 19888
# Yarn ports
EXPOSE 8030 8031 8032 8040 8042 8046 8047 8088 8090 8188 8190 8788 10200
#Other ports
EXPOSE 21 22

VOLUME ["/hdfs", "/opt/hadoop/logs", "/opt/hadoop/etc/hadoop"]

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
