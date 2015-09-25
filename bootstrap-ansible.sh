#!/bin/bash

# This script is executed on the control node to bootstrap ansible

# Install ansible
echo Installing ansible ...
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get -y install ansible

# Deploy vagrant insecure key
echo Copying ssh key ...
cp /vagrant/vagrant_insecure_key /home/vagrant/.ssh/id_rsa
chmod 600 /home/vagrant/.ssh/id_rsa
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa

# Execute ansible
echo Executing ansible ...
cd /vagrant/rssrecipes-ansible
ansible-playbook -i ../vagrant_ansible_inventory -e hardware_platform='emulab' run.yml
