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

### Configure the Kubernetes cluster

```sh
./cluster-up.sh
```

### Configure kubectl for Kubernetes cluster

```sh
cp ~/.kube/config ~/.kube/config.bak
cp config ~/.kube/
```

### Wait for all nodes to be ready

```sh
watch -n 1 kubectl get nodes
(Ctrl + c to brake)
```

### Destroy machines

```sh
vagrant destroy -f
```
