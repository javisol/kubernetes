# kubernetes
mis ejemplos y pruebas de kubernetes<br/>
Nada productivo, ejempos básicos para hacer pruebas en un laboratorio de kubernetes<br/>
Nothing useful. Just some basic code for testing in a kubernetes test environment<br/>

## Instalación cluster K8s

### Requisitos
2x vCPU
1024MB RAM
IP fija

### Instalación

#### En todos los nodos
```
sudo apt install docker.io -y
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg -o repo.key
sudo apt-key add repo.key
sudo add-apt-repository 'deb http://apt.kubernetes.io/ kubernetes-xenial main'
sudo apt install kubelet kubeadm kubernetes-cni -y 
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo swapoff -a
#además hay que desactivar el swap de /etc/fstab
# la siguiente es requerimiento de flannel
sudo sysctl net.bridge.bridge-nf-call-iptables=1
```

#### Configurar master
flannel usa el CIDR 10.244.0.0/16
calico usa el CIDR 192.168.0.0/16

el pod-network-cidr va acorde a esto
```
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=<ip-master> |tee cluster_init.txt
mkdir .kube
sudo cp /etc/kubernetes/admin.conf .kube/config
sudo chown <user>:<user> .kube/config
```

#### Instalar el CNI
Flannel:
```
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

Calico:
```
kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/kubeadm/1.7/calico.yaml
```

Weave.net:
```
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```
#### Configurar workers
```
sudo kubeadm join <ip-master>:6443 --token qbuk1t.n8rrp7duc7mryqdj --discovery-token-ca-cert-hash sha256:f320be0063af3090fc8dab602c23b3ec509aab693f9c4305dd5fcdc761016586
```
