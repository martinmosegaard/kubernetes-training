apt-get update
apt-get install -y docker.io
sudo usermod -a -G docker vagrant

sudo sed -i "/$(hostname)/d" /etc/hosts
sudo echo "
192.168.50.2 k8s-master
192.168.50.3 k8s-worker-0
192.168.50.4 k8s-worker-1
" >> /etc/hosts

# Required by Weave networking (because of some CNI plugins):
# https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#pod-network
sysctl net.bridge.bridge-nf-call-iptables=1

## Disable swap
swapoff -a
# Comment out the swap partition, so swap is also disabled after reboot
sudo sed -i.bak '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat > /etc/apt/sources.list.d/kubernetes.list <<EOF
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl

systemctl enable kubelet
systemctl enable docker
