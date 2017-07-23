# **hadoop**
___

### Description

This image runs the [*Cloudera CDH Hadoop*](https://www.cloudera.com/products/open-source/apache-hadoop/key-cdh-components.html) in a **pseudo-distributed** mode on a Centos 7 Linux distribution.

The *latest* tag of this image is build with the latest available release of CDH on Centos 7.

You can pull it with:

    docker pull parrotstream/hadoop


You can also find other images based on different Apache Hadoop releases, using a different tag in the following form:

    docker pull parrotstream/hadoop:[hadoop-release]-[cdh-release]


For example, if you want Apache Hadoop release 2.6.0 on CDH 5.11.1 you can pull the image with:

    docker pull parrotstream/hadoop:2.6.0-cdh5.11.1

Run with Docker Compose:

    docker-compose -p parrot up

Setting the project name to *parrot* with the **-p** option is useful to share the network created with the containers coming from other Parrot docker-compose.yml configurations.

Once started you'll be able to read the list of all the Hadoop Web GUIs urls:

| **Hadoop Web UIs**        |**URL**                            |
|:--------------------------|:----------------------------------|
| *Hadoop Name Node*        | http://localhost:50070            |
| *Hadoop Data Node*        | http://localhost:50075            |
| *YARN Node Manager*       | http://localhost:8042             |
| *YARN Resource Manager*   | http://localhost:8088             |
| *YARN Timeline History*   | http://localhost:8188             |
| *MapReduce Job History*   | http://localhost:19888/jobhistory |

While the Hadoop Docker container is running, you can always get the urls' list with the script:

    print-urls.sh

included in the GitHub source repository.

There are 3 named volumes defined:

- **hadoop_conf** wich points to HADOOP_CONF_DIR
- **hadoop_logs** which points to HADOOP_LOG_DIR
- **hadoop_hdfs** which contains the HDFS files for the primary and secondary name nodes

### Available tags:

- Apache Hadoop 2.8.1 ([2.8.1](https://github.com/parrot-stream/docker-hadoop/blob/2.8.1/Dockerfile), [latest](https://github.com/parrot-stream/docker-hadoop/blob/latest/Dockerfile))
- Apache Hadoop 2.8.0 ([2.8.0](https://github.com/parrot-stream/docker-hadoop/blob/2.8.0/Dockerfile))
- Apache Hadoop 2.7.3 ([2.7.3](https://github.com/parrot-stream/docker-hadoop/blob/2.7.3/Dockerfile))
- Apache Hadoop 2.6.4 ([2.6.4](https://github.com/parrot-stream/docker-hadoop/blob/2.6.4/Dockerfile))
- Apache Hadoop 2.6.0-cdh5.11.1 ([2.6.0-cdh5.11.1](https://github.com/parrot-stream/docker-hadoop/blob/2.6.0-cdh5.11.1/Dockerfile))
