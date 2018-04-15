# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    required_plugins = %w( vagrant-vbguest vagrant-disksize )
    _retry = false
    required_plugins.each do |plugin|
        unless Vagrant.has_plugin? plugin
            system "vagrant plugin install #{plugin}"
            _retry=true
        end
    end

    config.vm.box = "ubuntu/xenial64"
    config.vm.hostname = "juju"
    config.vm.define "juju"
#   config.vm.box_check_update = false
#   config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "private_network", ip: "192.168.33.12"
    config.vm.provider "virtualbox" do |vb|
        vb.name = "juju"
        vb.memory = "2048"
        vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
    end
    config.vm.provision "shell" do |sh|
        sh.path = "bootstrap.sh"
        sh.privileged = false
#       sh.args = ["kubernetes"] # or "openstack"
    end  

    config.vbguest.auto_update = true
    config.disksize.size = '20GB'
end
