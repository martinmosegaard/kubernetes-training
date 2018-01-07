ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'



Vagrant.configure("2") do |config|
  config.vm.boot_timeout = 500
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.gui = false
    vb.linked_clone = true
    vb.memory = 2048
    vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
  end

  config.vm.provision "shell", path: "install-kubeadm.sh"

  master_name = "k8s-master"
  config.vm.define master_name do |master|
    master.vm.network "private_network", ip: "192.168.50.2"
    master.vm.hostname = master_name
    master.vm.provision :shell, inline: "sed 's/127\.0\.0\.1.*.*/192\.168\.50\.2 k8s-master/' -i /etc/hosts"
  end

  2.times do |n|
    worker_name = "k8s-worker-#{n}"
    config.vm.define worker_name do |worker|
      worker.vm.network "private_network", ip: "192.168.50.#{n + 3}"
      worker.vm.hostname = worker_name
      worker.vm.provision :shell, inline: "sed 's/127\.0\.0\.1.*.*/192\.168\.50\.#{n + 3} k8s-worker-#{n}/' -i /etc/hosts"
    end
  end

#    lb_name = "k8s-lb" 
#    config.vm.define lb_name do |lb|
#      lb.vm.network "private_network", ip: "192.168.50.1"
#      lb.vm.hostname = lb_name
#    end

end
