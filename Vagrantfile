ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.gui = false
    vb.linked_clone = true
    vb.memory = 2048
  end

  config.vm.define "k8s-master" do |api|
    api.vm.provision "chef_solo" do |chef|
      chef.add_recipe "kubernetes::master"
    end
  end

  config.vm.define "k8s-worker-1"
  config.vm.define "k8s-worker-2"

end
