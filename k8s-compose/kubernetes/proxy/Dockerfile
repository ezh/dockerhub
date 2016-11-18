FROM  bashell/alpine-bash

ADD kube-proxy /usr/local/bin

ADD run.sh /

RUN chmod 755 /run.sh

CMD ["/run.sh"]
