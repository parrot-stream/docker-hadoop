FROM mcapitanio/centos-java:7-7u80

MAINTAINER Matteo Capitanio <matteo.capitanio@gmail.com>

USER root

ENV HADOOP_VER 2.7.2
ENV HADOOP_HOME /opt/hadoop
ENV HADOOP_PREFIX $HADOOP_HOME
ENV HADOOP_COMMON_HOME $HADOOP_HOME
ENV HADOOP_COMMON_LIB_NATIVE $HADOOP_PREFIX/lib/native
ENV HADOOP_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_CONF_DIR

ENV PATH $HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

# Install needed packages
RUN yum clean all; yum update -y; yum clean all
RUN yum install -y deltarpm
RUN yum install -y which openssh-clients openssh-server openssl python-setuptools
RUN easy_install supervisor

WORKDIR /opt/docker

# Apache Hadoop
RUN wget http://mirror.nohup.it/apache/hadoop/common/hadoop-$HADOOP_VER/hadoop-$HADOOP_VER.tar.gz
RUN tar -xvf hadoop-$HADOOP_VER.tar.gz -C ..; \
    mv ../hadoop-$HADOOP_VER $HADOOP_HOME
COPY hadoop/ $HADOOP_HOME/
COPY ./etc /etc
RUN chmod +x $HADOOP_HOME/etc/hadoop/*.sh
RUN chmod +x $HADOOP_HOME/bin/*.sh

RUN useradd -p $(echo "hdfs" | openssl passwd -1 -stdin) hdfs; \
    groupadd supergroup; \
    groupadd hdfs; \
    usermod -a -G supergroup hdfs; \
    usermod -a -G wheel hdfs

RUN mkdir -p /hdfs; \
    hdfs namenode -format

ADD ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

# hdfs-default.xml ports
EXPOSE 50010 50020 50070 50075 50090 50091 50100 50105 50475 50470 8020 8485 8480 8481
# mapred-default.xml ports
EXPOSE 50030 50060 13562 10020 19888
#Yarn ports
EXPOSE 8030 8031 8032 8040 8042 8046 8047 8088 8090 8188 8190 8788 10200
#Other ports
EXPOSE 21 22

VOLUME ["/hdfs", "/opt/hadoop/logs", "/opt/hadoop/etc/hadoop"]

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
