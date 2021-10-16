# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

  config.vm.provision "shell", path: "bootstrap.sh"

  # Kubernetes Master Server
  config.vm.define "kmaster" do |node|
  
    node.vm.box               = "generic/ubuntu2004"
    node.vm.box_check_update  = false
    node.vm.hostname          = "kmaste.batpool.com"

    node.vm.network "private_network", ip: "192.168.58.100"
  
    node.vm.provider :virtualbox do |v|
      v.name    = "kmaster"
      v.memory  = 2048
      v.cpus    =  2
    end
  
    node.vm.provision "shell", path: "bootstrap_kmaster.sh"
  
  end


  # Kubernetes Worker Nodes
  NodeCount = 2

  (1..NodeCount).each do |i|

    config.vm.define "kworker#{i}" do |node|

      node.vm.box               = "generic/ubuntu2004"
      node.vm.box_check_update  = false
      node.vm.hostname          = "kworker#{i}.batpool.com"

      node.vm.network "private_network", ip: "192.168.58.10#{i}"

      node.vm.provider :virtualbox do |v|
        v.name    = "kworker#{i}"
        v.memory  = 1024
        v.cpus    = 1
      end

      node.vm.provision "shell", path: "bootstrap_kworker.sh"

    end

  end

end
