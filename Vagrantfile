# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
	config.vm.box = "ubuntu/trusty64"
	config.hostmanager.enabled = true
	config.hostmanager.manage_host = false
	config.ssh.insert_key = false

	########################################
	# (1) Configure virtual machines
	########################################
	config.vm.define "machine1" do |machine|
		machine.vm.network "private_network", ip: "192.168.77.21"
		machine.vm.provider "virtualbox" do |v|
			v.customize ["modifyvm", :id, "--memory", 1024]
			v.customize ["modifyvm", :id, "--cpus", 1]
			v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
			v.customize ["modifyvm", :id, "--nictype1", "virtio"]
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end
	config.vm.define "machine2" do |machine|
		machine.vm.network "private_network", ip: "192.168.77.22"
		machine.vm.provider "virtualbox" do |v|
			v.customize ["modifyvm", :id, "--memory", 1024]
			v.customize ["modifyvm", :id, "--cpus", 1]
			v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
			v.customize ["modifyvm", :id, "--nictype1", "virtio"]
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end
	config.vm.define "machine3" do |machine|
		machine.vm.network "private_network", ip: "192.168.77.23"
		machine.vm.provider "virtualbox" do |v|
			v.customize ["modifyvm", :id, "--memory", 1024]
			v.customize ["modifyvm", :id, "--cpus", 1]
			v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
			v.customize ["modifyvm", :id, "--nictype1", "virtio"]
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end
	config.vm.define "machine4" do |machine|
		machine.vm.network "private_network", ip: "192.168.77.24"
		machine.vm.provider "virtualbox" do |v|
			v.customize ["modifyvm", :id, "--memory", 1024]
			v.customize ["modifyvm", :id, "--cpus", 1]
			v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
			v.customize ["modifyvm", :id, "--nictype1", "virtio"]
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end
	config.vm.define "machine5" do |machine|
		machine.vm.network "private_network", ip: "192.168.77.25"
		machine.vm.provider "virtualbox" do |v|
			v.customize ["modifyvm", :id, "--memory", 2048]
			v.customize ["modifyvm", :id, "--cpus", 1]
			v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
			v.customize ["modifyvm", :id, "--nictype1", "virtio"]
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end
	config.vm.define "machine6" do |machine|
		machine.vm.network "private_network", ip: "192.168.77.26"
		machine.vm.provider "virtualbox" do |v|
			v.customize ["modifyvm", :id, "--memory", 1024]
			v.customize ["modifyvm", :id, "--cpus", 1]
			v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
			v.customize ["modifyvm", :id, "--nictype1", "virtio"]
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
		# Only execute once the Ansible provisioner,
		# when all the machines are up and ready.
		machine.vm.provision :ansible do |ansible|
			# Disable default limit to connect to all the machines
			ansible.limit = 'all'
			ansible.playbook = "rssrecipes-ansible/run.yml"
			########################################
			# (2) Assign virtual machines to groups
			########################################
			ansible.groups = {
				"loadbalancer" => ["machine1"],
				"edge" => ["machine2"],
				"middletier" => ["machine3"],
				"eureka" => ["machine4"],
				"database" => ["machine5"],
				"rssserver" => ["machine6"],
				"recipes:children" => ["edge", "middletier"],
				"tomcat:children" => ["eureka", "rssserver"],
			}
		end
	end
end
