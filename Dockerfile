FROM mcapitanio/centos-java:7-7u80

MAINTAINER Matteo Capitanio <matteo.capitanio@gmail.com>

USER root

ENV http_proxy ${http_proxy}
ENV https_proxy ${https_proxy}
ENV no_proxy ${no_proxy}

ENV HADOOP_VER 2.6.4
ENV HADOOP_HOME /opt/hadoop
ENV HADOOP_PREFIX $HADOOP_HOME
ENV HADOOP_COMMON_HOME $HADOOP_HOME
ENV HADOOP_COMMON_LIB_NATIVE $HADOOP_PREFIX/lib/native
ENV HADOOP_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_CONF_DIR

ENV PATH $HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

# Install needed packages
RUN yum clean all; \
    yum update -y; \
    yum install -y deltarpm; \
    yum install -y which openssh-clients openssh-server openssl python-setuptools; \
    easy_install supervisor

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

COPY hadoop/ $HADOOP_HOME/
COPY ./etc /etc
RUN chmod +x $HADOOP_HOME/etc/hadoop/*.sh
RUN chmod +x $HADOOP_HOME/bin/*.sh

RUN rm -rf /hdfs; \
    mkdir -p /hdfs; \
    chown -R hdfs:hdfs /hdfs; \
    chown -R hdfs:hdfs $HADOOP_HOME

USER hdfs
RUN mkdir -p $HADOOP_HOME/logs; \
    hdfs namenode -format
USER root

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
