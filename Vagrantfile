# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
	config.vm.box = "ubuntu/trusty32"
	config.hostmanager.enabled = true
	config.hostmanager.manage_host = false
	config.ssh.insert_key = false

	########################################
	# Configure virtual machines
	########################################
	config.vm.define "machine1" do |machine|
		machine.vm.network "private_network", ip: "192.168.77.21"
		machine.vm.provider "virtualbox" do |v|
			v.customize ["modifyvm", :id, "--memory", 512]
			v.customize ["modifyvm", :id, "--cpus", 1]
			v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
			v.customize ["modifyvm", :id, "--nictype1", "virtio"]
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end
	config.vm.define "machine2" do |machine|
		machine.vm.network "private_network", ip: "192.168.77.22"
		machine.vm.provider "virtualbox" do |v|
			v.customize ["modifyvm", :id, "--memory", 512]
			v.customize ["modifyvm", :id, "--cpus", 1]
			v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
			v.customize ["modifyvm", :id, "--nictype1", "virtio"]
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end
	config.vm.define "machine3" do |machine|
		machine.vm.network "private_network", ip: "192.168.77.23"
		machine.vm.provider "virtualbox" do |v|
			v.customize ["modifyvm", :id, "--memory", 512]
			v.customize ["modifyvm", :id, "--cpus", 1]
			v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
			v.customize ["modifyvm", :id, "--nictype1", "virtio"]
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end
	config.vm.define "machine4" do |machine|
		machine.vm.network "private_network", ip: "192.168.77.24"
		machine.vm.provider "virtualbox" do |v|
			v.customize ["modifyvm", :id, "--memory", 512]
			v.customize ["modifyvm", :id, "--cpus", 1]
			v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
			v.customize ["modifyvm", :id, "--nictype1", "virtio"]
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end
	config.vm.define "machine5" do |machine|
		machine.vm.network "private_network", ip: "192.168.77.25"
		machine.vm.provider "virtualbox" do |v|
			v.customize ["modifyvm", :id, "--memory", 1024]
			v.customize ["modifyvm", :id, "--cpus", 1]
			v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
			v.customize ["modifyvm", :id, "--nictype1", "virtio"]
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end
	config.vm.define "machine6" do |machine|
		machine.vm.network "private_network", ip: "192.168.77.26"
		machine.vm.provider "virtualbox" do |v|
			v.customize ["modifyvm", :id, "--memory", 512]
			v.customize ["modifyvm", :id, "--cpus", 1]
			v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
			v.customize ["modifyvm", :id, "--nictype1", "virtio"]
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end
	config.vm.define "machine7" do |machine|
		machine.vm.network "private_network", ip: "192.168.77.27"
		machine.vm.provider "virtualbox" do |v|
			v.customize ["modifyvm", :id, "--memory", 512]
			v.customize ["modifyvm", :id, "--cpus", 1]
			v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
			v.customize ["modifyvm", :id, "--nictype1", "virtio"]
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end

	########################################
	# Configure control node
	########################################
	config.vm.define "machine0" do |machine|
		machine.vm.network "private_network", ip: "192.168.77.20"
		machine.vm.provider "virtualbox" do |v|
			v.customize ["modifyvm", :id, "--memory", 512]
			v.customize ["modifyvm", :id, "--cpus", 1]
			v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
			v.customize ["modifyvm", :id, "--nictype1", "virtio"]
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
		machine.vm.provision "shell", path: "bootstrap-ansible.sh", privileged: false
	end
end
