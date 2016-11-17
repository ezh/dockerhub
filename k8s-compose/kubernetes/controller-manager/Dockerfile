FROM  bashell/alpine-bash:latest

ADD kube-controller-manager /usr/local/bin

ADD run.sh /

RUN chmod 755 /run.sh

CMD ["/run.sh"]
