# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
	config.vm.box = "ubuntu/trusty64"
	config.hostmanager.enabled = true
	config.hostmanager.manage_host = false
	config.ssh.insert_key = false

	N = 6
	(1..N).each do |machine_id|
		config.vm.define "machine#{machine_id}" do |machine|
			#machine.vm.hostname = "machine#{machine_id}"
			machine.vm.network "private_network", ip: "192.168.77.#{20+machine_id}"
			# Only execute once the Ansible provisioner,
			# when all the machines are up and ready.
			if machine_id == N
				machine.vm.provision :ansible do |ansible|
					# Disable default limit to connect to all the machines
					ansible.limit = 'all'
					ansible.playbook = "rssrecipes-ansible/run.yml"
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

		config.vm.provider "virtualbox" do |v|
			v.customize ["modifyvm", :id, "--memory", 2048]
			v.customize ["modifyvm", :id, "--cpus", 1]
			v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
			v.customize ["modifyvm", :id, "--nictype1", "virtio"]
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end
	# TODO
	# config.vm.post_up_message

end
