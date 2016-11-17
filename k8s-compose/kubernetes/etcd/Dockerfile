FROM bashell/alpine-bash:latest

ADD etcd /usr/local/bin

ADD run.sh /

RUN chmod 755 /run.sh

VOLUME ["/var/etcd/data"]

CMD ["/run.sh"]
