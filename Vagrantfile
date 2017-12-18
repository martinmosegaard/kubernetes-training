ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.linked_clone = true
    vb.memory = "2048"
  end

  config.vm.define "k8s-api"
  config.vm.define "k8s-etcd"
  config.vm.define "k8s-controller-manager"

end
