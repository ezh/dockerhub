FROM  10.62.100.88:9999/ubuntu:14.04

ADD kubelet /usr/local/bin

ADD run.sh /

RUN chmod 755 /run.sh

CMD ["/run.sh"]
