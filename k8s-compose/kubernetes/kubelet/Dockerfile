FROM ubuntu:latest

ADD kubelet /usr/local/bin

ADD run.sh /

RUN chmod 755 /run.sh

CMD ["/run.sh"]
