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

### Destroy machines

```sh
vagrant destroy -f
```
