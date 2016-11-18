# Kubernetes Cluster
master: 192.168.31.148
minion1: 192.168.31.148
minion2: 192.168.31.149
minion3: 192.168.31.150

# Run Cluster Step
step1: put application in /usr/local/bin
      master: etcd/kube-apiserver/kube-controller-manager/kube-scheduler
      minion: kubelet/kube-proxy

step2: execute script
       master: env.sh--->
               kube-etcd.sh--->
               kube-apiserver.sh--->
               kube-controller-manager.sh--->
               kube-scheduler.sh
        minion: env.sh--->
                kubelet.sh--->
                kube-proxy.sh

# Reference
http://www.cnblogs.com/lyzw/p/6016789.html
