# **hadoop**
___

### Description
___

This image runs the official [*Apache Hadoop*](http://hadoop.apache.org/) in a **pseudo-distributed** mode on a Centos Linux distribution.

The *latest* tag of this image is build with the [latest stable](http://hadoop.apache.org/releases.html) release of Apache Hadoop on Centos 7.

You can pull it with:

    docker pull mcapitanio/hadoop


You can also find other images based on different Apache Hadoop releases, using a different tag in the following form:

    docker pull mcapitanio/hadoop:[hadoop-release]


For example, if you want Apache Hadoop release 2.6.4 you can pull the image with:

    docker pull mcapitanio/hadoop:2.6.4


Run with Docker Compose:

    docker-compose -p docker up

Setting the project name to *docker* with the **-p** option is useful to share the named data volumes created with with the containers created with other docker-compose.yml configurations (for example the one of the [HBase Docker image]((https://hub.docker.com/r/mcapitanio/hbase/))).

Once started you'll be able to read the list of all the Hadoop Web GUIs urls, for example (the ip is non static!):

| **Hadoop Web GUIs**       |**URL**                             |
|:--------------------------|:-----------------------------------|
| *Hadoop Name Node*        | http://172.17.0.3:50070            |
| *Hadoop Data Node*        | http://172.17.0.3:50075            |
| *YARN Node Manager*       | http://172.17.0.3:8042             |
| *YARN Resource Manager*   | http://172.17.0.3:8088             |
| *YARN Timeline History*   | http://172.17.0.3:8188             |
| *MapReduce Job History*   | http://172.17.0.3:19888/jobhistory |

While the Hadoop Docker container is running, you can always get the urls' list with the script:

    print-urls.sh

included in the GitHub source repository.

There are 3 named volumes defined:

- **hadoop_conf** wich points to HADOOP_CONF_DIR
- **hadoop_logs** which points to HADOOP_LOG_DIR
- **hadoop_hdfs** which contains the HDFS files for the primary and secondary name nodes

### Available tags:

- Apache Hadoop 2.7.2 ([2.7.2](https://github.com/mcapitanio/docker-hadoop/blob/2.7.2/Dockerfile), [latest](https://github.com/mcapitanio/docker-hadoop/blob/latest/Dockerfile))
- Apache Hadoop 2.6.4 ([2.6.4](https://github.com/mcapitanio/docker-hadoop/blob/2.6.4/Dockerfile))
