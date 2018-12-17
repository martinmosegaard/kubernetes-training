####### Install docker
yum update
yum install -y git
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# docker 18.09.0 not validated by kube 1.13.1
yum install -y docker-ce-18.06.1.ce
sudo usermod -a -G docker vagrant
systemctl enable docker
systemctl start docker
#######

####### Disable swap
swapoff -a
# Comment out the swap partition, so swap is also disabled after reboot
sudo sed -i.bak '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

####### Add cluster node IPs to hosts file
sudo sed -i "/$(hostname)/d" /etc/hosts
sudo echo "
192.168.50.2 k8s-master
192.168.50.3 k8s-worker-0
192.168.50.4 k8s-worker-1
" >> /etc/hosts
#######

####### Install kubeadm, kubelet and kubectl
# https://kubernetes.io/docs/setup/independent/install-kubeadm/
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF

# Set SELinux in permissive mode (effectively disabling it)
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

yum install -y kubelet-1.13-1 kubeadm-1.13.1 kubectl-1.13.1 --disableexcludes=kubernetes

systemctl enable kubelet && systemctl start kubelet
#######

####### Fix issues with traffic being routed incorrectly due to iptables being bypassed
# https://kubernetes.io/docs/setup/independent/install-kubeadm/
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

# the line below is required by flannel, but isn't it the same as above?
# sysctl net.bridge.bridge-nf-call-iptables=1
#######
