FROM alpine-bash:latest

MAINTAINER "goldonship" <goldon.qian@gmail.com>

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

ADD java-1.8-openjdk.tar.gz /usr/lib/jvm

RUN ln -sv /usr/lib/jvm/java-1.8-openjdk /usr/lib/jvm/default-jvm 

RUN ln -sv /usr/lib/jvm/default-jvm/jre/bin/java /usr/bin/java
