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

  config.vm.define "k8s-master" do |master|
    master.vm.network "private_network", ip: "192.168.50.2"
  end

  2.times do |n|
    config.vm.define "k8s-worker-#{n}" do |worker|
      worker.vm.network "private_network", ip: "192.168.50.#{n + 3}"
    end
  end

end
