#!/bin/bash

# This script is executed on the control node to bootstrap ansible

# Install ansible
echo Installing ansible ...
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get -y install ansible git

# Deploy vagrant insecure key
echo Copying ssh key ...
cp /vagrant/vagrant_insecure_key /home/vagrant/.ssh/id_rsa
chmod 600 /home/vagrant/.ssh/id_rsa
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa

# Clone recipes-rss-ansible
cd /tmp
git clone https://github.com/hora-prediction/recipes-rss-ansible.git

# Configure ansible variables for vagrant environment
cd /tmp/recipes-rss-ansible/group_vars
sed -i 's/use_short_hostname: false/use_short_hostname: true/' all

# Execute ansible
echo Executing ansible ...
cd /tmp/recipes-rss-ansible
ansible-playbook -i /vagrant/vagrant_ansible_inventory run.yml
