# kubernetes-training

Kubernetes training resources.

## Setting up a Kubernetes cluster

The `Vagrantfile` can be used to start VMs for a Kubernetes cluster:

- One master, `k8s-master`
- Two workers, `k8s-worker-0` and `k8s-worker-1`

### Create and provision machines

```sh
vagrant up
```

### Setting up the master

```sh
vagrant ssh k8s-master

sudo kubeadm init --apiserver-advertise-address 192.168.50.2
```

### Setting up the workers

```sh
vagrant ssh k8s-worker-0

sudo kubeadm join <TOKEN>
```

### Destroy machines

```sh
vagrant destroy -f
```
