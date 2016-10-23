FROM openjdk:1.8

MAINTAINER "qianguodong" <goldon.qian@gmail.com>

ARG HBASE_VERSION=1.2.3

ENV PATH $PATH:/hbase/bin

WORKDIR /

ADD hbase-$HBASE_VERSION-bin.tar.gz .

RUN ln -sv hbase-$HBASE_VERSION  hbase

COPY start-hbase.sh /hbase/bin

COPY hbase-site.xml /hbase/conf

EXPOSE 2181 16010

CMD ["/hbase/bin/start-hbase.sh"]
