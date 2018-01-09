# kubernetes-training

Create a Kubernetes cluster with Vagrant and VirtualBox.

This is meant as a cost-free alternative to the excellent tutorial
[Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way),
while being slightly more real than [Minikube](https://github.com/kubernetes/minikube).

## Prerequisites

- Vagrant
- VirtualBox 5.2
- `kubectl`

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

### Configure local kubectl for Kubernetes cluster

```sh
cp -i config ~/.kube/
```

### Verify

```sh
$ kubectl get nodes
NAME           STATUS     ROLES     AGE       VERSION
k8s-master     Ready      master    48s       v1.9.1
k8s-worker-0   Ready      <none>    29s       v1.9.1
k8s-worker-1   Ready      <none>    23s       v1.9.1
```

Then perform some smoke tests like using your local `kubectl` to run a container as done here:
<https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/13-smoke-test.md>

### Destroy machines

```sh
vagrant destroy -f
```
