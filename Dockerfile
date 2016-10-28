FROM  bashell/alpine-bash:latest

MAINTAINER "qianguodong" <qian.guodong5@zte.com.cn>

ENV JAVA_HOME /usr/local/java-1.8-openjdk

ADD java-1.8-openjdk.tar.gz /usr/local

RUN ln -sv /usr/local/java-1.8-openjdk/jre/bin/java /usr/bin/java 

ARG HBASE_VERSION=1.0.3

ENV PATH $PATH:/hbase/bin

WORKDIR /

ADD hbase-$HBASE_VERSION-bin.tar.gz .

RUN ln -sv hbase-$HBASE_VERSION hbase 

ARG KAFKA_VERSION=0.10.0.0

ARG SCALA_VERSION=2.11

ADD kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tar.gz /usr/local

ENV KAFKA_HOME /usr/local/kafka_${SCALA_VERSION}-${KAFKA_VERSION}

EXPOSE 2181 16010 9092

ADD entrypoint.sh /

RUN chmod 755 /entrypoint.sh

CMD ["/entrypoint.sh"]
