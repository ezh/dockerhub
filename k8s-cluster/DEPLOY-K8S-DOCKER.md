http://www.cnblogs.com/softlin/p/5656764.html


Kubernetes为Google开源的容器管理框架，提供了Docker容器的夸主机、集群管理、容器部署、高可用、弹性伸缩等一系列功能；Kubernetes的设计目标包括使容器集群任意时刻都处于用户期望的状态，因而建立了一整套集群管理机制：容器自动重启、自动备份、容器自动伸缩等；Kubernetes设计了pod、replication controller、service用于管理容器的了组件，并提供了RESTful格式接口用于操作他们；由于本篇文章主要是Kubernetes所以就不对理论相关进行过多介绍了；
　　本篇文章把Kubernetes部署到Docker中，使用三个节点192.168.2.143同时为Master和minion节点，另外还有192.168.2.144、192.168.2.145两个minion节点；

1、master节点启动etcd容器
启动etcd容器

 --绑定4001端口
 docker run -d --net=host --restart=always --name=etcd -v /var/etcd/data:/var/etcd/data  kubernetes/etcd:2.0.5  /usr/local/bin/etcd --addr=192.168.2.143:4001 --bind-addr=0.0.0.0:4001 --data-dir=/var/etcd/data

　　在etcd里插入flannel配置信息，指定flannel使用10.0.0.0/8区间

 docker exec -it etcd etcdctl set /solinx.co/network/config '{"Network":"10.0.0.0/8"}'  

2、在master、minion1、minion2节点配置flanneld

 启动flanneld, wget -c https://github.com/coreos/flannel/releases/download/v0.5.5/flannel-0.5.5-linux-amd64.tar.gz

 ./flanneld --etcd-endpoints=http://192.168.2.143:4001 --etcd-prefix=/solinx.co/network --iface=ens33 > flannel.log  2>&1 &

　　flannel启动后获得可用于分配的IP集合，存放于/run/flannel/subnet.env中，需要配置docker可用与分配的IP

　　Ubuntu下修改Docker配置文件

  在/etc/systemd/system/docker.service  增加EnvironmentFile=-/etc/default/docker
 修改ExecStart=/usr/bin/docker -d -H fd://  ,改成:  ExecStart=/usr/bin/docker -d -H fd:// $DOCKER_OPTS

 source /run/flannel/subnet.env
 sh -c "echo DOCKER_OPTS=\\\"--bip=$FLANNEL_SUBNET --mtu=$FLANNEL_MTU\\\" >> /etc/default/docker"

 service docker restart

3、Kubernetes部署
下载kubernetes.tar.gz到master、minion节点中

 wget -c https://github.com/kubernetes/kubernetes/releases/download/v1.2.5/kubernetes.tar.gz

　　tar -zxvf 解压kubernetes.tar.gz文件后在kubernetes/server目录中找到kubernetes-server-linux-amd64.tar.gz将其解压，然后在kubernetes/server/bin目录下找到：kube-apiserver.tar、kube-controller-manager.tar、kube-scheduler.tar；
　　在master节点中导入kubernetes Docker镜像文件

 docker load -i kube-apiserver.tar
 docker load -i kube-controller-manager.tar
 docker load -i kube-scheduler.tar

这里flannel与kubernetes使用同一个etcd

master节点启动apiServer

 docker run -d --name=apiserver --net=host gcr.io/google_containers/kube-apiserver:7bf05b2d35172296e4fbd2604362456f kube-apiserver --insecure-bind-address=192.168.2.143 --service-cluster-ip-range=10.0.0.0/16 --etcd-servers=http://192.168.2.143:4001  

master节点启动ControllerManager

 docker run -d --name=ControllerM gcr.io/google_containers/kube-controller-manager:6c95ef0b57ac9deda34ae1a4a40baa0a kube-controller-manager --master=192.168.2.143:8080

master节点启动Scheduler

 docker run -d --name=scheduler gcr.io/google_containers/kube-scheduler:e5342c3d8ced06850af97347daf6ae4b kube-scheduler --master=192.168.2.143:8080

服务端启动完成

 ./kubectl -s 192.168.2.143:8080 version 查看kubernetes版本信息

 Client Version: version.Info{Major:"1", Minor:"2", GitVersion:"v1.2.5", GitCommit:"25eb53b54e08877d3789455964b3e97bdd3f3bce", GitTreeState:"clean"}
 Server Version: version.Info{Major:"1", Minor:"2", GitVersion:"v1.2.5", GitCommit:"25eb53b54e08877d3789455964b3e97bdd3f3bce", GitTreeState:"clean"}

在Master节点查看服务Container启动情况：

 docker ps  

在143、144、145 minion节点启动kubelet

取得minion节点IP

 NODE_IP=`ifconfig ens33 | grep 'inet addr:' | cut -d: -f2 | cut -d' ' -f1`

 ./kubelet --api-servers=192.168.2.143:8080 --node-ip=$NODE_IP --hostname_override=192.168.2.144 > kubelet.log 2>&1 &

注意如果当前两个几点的主机名相同则一定要使用hostname_override参数，否则需要把主机名改为不同的；

在master上查看节点信息

 ./kubectl -s 192.168.2.143:8080 get no

节点状态

在143、144、145节点启动kube-proxy

 ./kube-proxy --master=192.168.2.143:8080 > proxy.log 2>&1 &

下面的命令来查看pod、replication controller、service和endpoint：

 ./kubectl -s 192.168.1.143:8080 get po
 ./kubectl -s 192.168.1.143:8080 get rc
 ./kubectl -s 192.168.1.143:8080 get svc
 ./kubectl -s 192.168.1.143:8080 get ep  
