# k8s-training

Kubernetes training resources.

## Vagrant

*Note:* Chef is not used, because of https://github.com/chef-cookbooks/kubernetes/issues/20

```sh
# Download cookbooks used by Chef provisioners
berks vendor cookbooks/

# Start Vagrant VMs
vagrant up
```

## Setting up cluster

Master:

```sh
vagrant ssh k8s-master

sudo kubeadm init --apiserver-advertise-address 192.168.50.2
```

Workers:

```sh
sudo kubeadm join <TOKEN>
```
