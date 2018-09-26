# **hadoop**
___

### Description

This image runs the official [*Apache Hadoop*](http://hadoop.apache.org/) in a **pseudo-distributed** mode on a Centos Linux distribution.

The *latest* tag of this image is build with the [latest stable](http://hadoop.apache.org/releases.html) release of Apache Hadoop on Centos 7.

You can pull it with:

    docker pull parrotstream/hadoop


You can also find other images based on different Apache Hadoop releases, using a different tag in the following form:

    docker pull parrotstream/hadoop:[hadoop-release]


For example, if you want Apache Hadoop release 2.6.4 you can pull the image with:

    docker pull parrotstream/hadoop:2.6.4


Run with Docker Compose:

    docker-compose -p parrot up

Setting the project name to *parrot* with the **-p** option is useful to share the network created with the containers coming from other Parrot docker-compose.yml configurations.

Once started you'll be able to read the list of all the Hadoop Web GUIs urls:

| **Hadoop Web UIs**        |**URL**                            |
|:--------------------------|:----------------------------------|
| *Hadoop Name Node*        | http://localhost:9870            |
| *Hadoop Data Node*        | http://localhost:9864            |
| *YARN Node Manager*       | http://localhost:8042             |
| *YARN Resource Manager*   | http://localhost:8088             |
| *YARN Timeline History*   | http://localhost:8188             |
| *MapReduce Job History*   | http://localhost:19888/jobhistory |

While the Hadoop Docker container is running, you can always get the urls' list with the script:

    print-urls.sh

included in the GitHub source repository.

### Available tags:

- Apache Hadoop 3.0.3 ([3.0.3](https://github.com/parrot-stream/docker-hadoop/blob/3.0.3/Dockerfile), [latest](https://github.com/parrot-stream/docker-hadoop/blob/latest/Dockerfile))
- Apache Hadoop 2.8.5 ([2.8.5](https://github.com/parrot-stream/docker-hadoop/blob/2.8.5/Dockerfile))
- Apache Hadoop 2.8.1 ([2.8.1](https://github.com/parrot-stream/docker-hadoop/blob/2.8.1/Dockerfile))
- Apache Hadoop 2.8.0 ([2.8.0](https://github.com/parrot-stream/docker-hadoop/blob/2.8.0/Dockerfile))
- Apache Hadoop 2.7.3 ([2.7.3](https://github.com/parrot-stream/docker-hadoop/blob/2.7.3/Dockerfile))
- Apache Hadoop 2.6.4 ([2.6.4](https://github.com/parrot-stream/docker-hadoop/blob/2.6.4/Dockerfile))
- Apache Hadoop 2.6.0-cdh5.15.1 ([2.6.0-cdh5.15.1](https://github.com/parrot-stream/docker-hadoop/blob/2.6.0-cdh5.15.1/Dockerfile))
- Apache Hadoop 2.6.0-cdh5.11.1 ([2.6.0-cdh5.11.1](https://github.com/parrot-stream/docker-hadoop/blob/2.6.0-cdh5.11.1/Dockerfile))
