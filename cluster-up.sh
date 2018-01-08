#!/bin/bash

# Clean up from last time
rm -fv config kubeadm-join

# Initialize the master.
# The API server address is needed because the node has many network interfaces.
# Save the console output, because it contains commands to execute afterwards.
vagrant ssh k8s-master -c "sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address 192.168.50.2 > /tmp/kubeadm-init"

# Get the start commands to execute on the master. These are shown after "start using" and start with a blank space.
# Then execute them.
vagrant ssh k8s-master -c "grep --after 4 'start using' /tmp/kubeadm-init | grep '^ ' > /tmp/kubeadm-master-start"
vagrant ssh k8s-master -c "source /tmp/kubeadm-master-start"

# Apply weave network
# https://www.weave.works/docs/net/latest/kubernetes/kube-addon/
vagrant ssh k8s-master -c "kubectl apply -f \"https://cloud.weave.works/k8s/net?k8s-version=\$(kubectl version | base64 | tr -d '\n')\""

# Get the join command for the workers
vagrant ssh k8s-master -c "grep 'kubeadm join' /tmp/kubeadm-init" > kubeadm-join

# Execute the join command on the workers
cat kubeadm-join | xargs -I {} vagrant ssh k8s-worker-0 -c "sudo {}"
cat kubeadm-join | xargs -I {} vagrant ssh k8s-worker-1 -c "sudo {}"

# Getting setup for kubectl on workstation
vagrant ssh k8s-master -c "sudo cat /etc/kubernetes/admin.conf" > config

# Alert user about routing
echo "
Routing added to each hosts /etc/hosts:
192.168.50.2 k8s-master
192.168.50.3 k8s-worker-0
192.168.50.4 k8s-worker-1
"

echo "
#######################
 Cluster configuration
#######################
Created kubectl config file to match cluster.
Copy to ~/.kube/ folder:

cp config ~/.kube/

Then verify with:

kubectl get nodes
"
