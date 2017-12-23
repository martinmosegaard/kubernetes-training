ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.gui = false
    vb.linked_clone = true
    vb.memory = 2048
  end

  config.vm.provision "shell", path: "install-kubeadm.sh"

  master_name = "k8s-master"
  config.vm.define master_name do |master|
    master.vm.network "private_network", ip: "192.168.50.2"
    master.vm.hostname = master_name
  end

  2.times do |n|
    worker_name = "k8s-worker-#{n}"
    config.vm.define worker_name do |worker|
      worker.vm.network "private_network", ip: "192.168.50.#{n + 3}"
      worker.vm.hostname = worker_name
    end
  end

end
