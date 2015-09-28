# Netflix's RSS recipes with Vagrant and Ansible
This setup provides an easy way to run Netflix's distributed RSS reader application (https://github.com/hora-prediction/recipes-rss.git) on one physical machine using Vagrant and Ansible.

## Architecture of this setup

    +-------------------------------------------------------------------------------+
    |         .21                 .22                 .23                 .25       |
    |    +------------+      +------------+      +------------+      +------------+ |
    | :80|loadbalancer| :9090|    edge    | :9191| middletier | :9160|  database  | |
    | -->| (machine1) |----->| (machine2) |----->| (machine3) |----->| (machine5) | |
    |    +------------+      +------------+      +------------+      +------------+ |
    |                                \               /    \                         |
    |                                 \             /      \                        |
    |                                  \:80        /:80     \:80                    |
    |           .20                     \   .24   /          \     .26              |
    |      +------------+             +------------+         +------------+         |
    |      |Control node|             |   Eureka   |         | Feed server|         |
    |      | (machine0) |             | (machine4) |         | (machine6) |         |
    |      +------------+             +------------+         +------------+         |
    |                                                                               |
    |                               Virtual machines                                |
    |                             (created by Vagrant)                              |
    +-------------------------------------------------------------------------------+
    |                                  VirtualBox                                   |
    +-------------------------------------------------------------------------------+
    |                                     Host                                      |
    +-------------------------------------------------------------------------------+

At startup, vagrant creates all VMs spcified in the ```Vagrantfile```. When all VMs are created, vagrant executes the ```bootstrap-ansible.sh``` script on the control node. This script installs ansible on the control node and executes the ansible playbook ```run.yml``` which sets up and starts the application.

## System requirements
- A Windows, Mac, or Linux host machine with
   - 8 GB of RAM (this setup consumes approx. 6 GB)
   - 20 GB of disk space in home directory
- with the following packages installed
   - VirtualBox
   - Vagrant (>=1.7.4)
   - Vagrant hostmanager plugin (by executing ```vagrant plugin install vagrant-hostmanager``` after Vagrant is installed)

## Instruction

### How to setup and run the application
0. Clone this repository
0. Inside the cloned repository, execute ```vagrant up```. This step can take up to 30 minutes.

### Using the application
0. The RSS reader application can be accessed at http://192.168.77.21/jsp/rss.jsp from the host machine.
0. Add RSS feeds from the following URLs:
   - http://192.168.77.26/feeds/abc.xml
   - http://192.168.77.26/feeds/bbc.xml
   - http://192.168.77.26/feeds/cnn.xml
   - http://192.168.77.26/feeds/dw.xml
   - http://192.168.77.26/feeds/forbes.xml
   - http://192.168.77.26/feeds/reuters.xml
   - http://192.168.77.26/feeds/spiegel.xml
   - http://192.168.77.26/feeds/wsj.xml
0. The feeds can be removed by clicking the delete icon.

### Stopping the application and exporting application log
All controls must be done inside the control node (machine0) where the ansible and the playbooks are located. The following steps assume that you have already ssh'ed into the control node by executing ```vagrant ssh machine0``` and have changed the current working directory to ```/tmp/recipes-rss-ansible``` inside the control node. For a Windows host, please refer to http://docs-v1.vagrantup.com/v1/docs/getting-started/ssh.html regarding how to ssh into the control node.

0. Stop the application by executing
```ansible-playbook -i /vagrant/vagrant_ansible_inventory -u vagrant stop.yml```
0. Copy the log files from all nodes to the control node by executing
```ansible-playbook -i /vagrant/vagrant_ansible_inventory -u vagrant copy-log.yml```.
The log files will be copied to ```/tmp/RSSRecipesLog``` of the control node.
These files can be copied back to the host machine by copying them to ```/vagrant```.
This directory is shared between the host and all VMs.
0. The log files on all nodes can be cleaned by executing
```ansible-playbook -i /vagrant/vagrant_ansible_inventory -u vagrant clean.yml```
0. The application can be started again by executing
```ansible-playbook -i /vagrant/vagrant_ansible_inventory -u vagrant start.yml```
0. All VMs created in this setup can be removed completely by executing ```vagrant destroy -f``` on the host.

## How to scale the application
The application allows horizontal scaling of the edge and middletier. Scaling the application involves editing two configuration files:
- ```Vagrantfile``` which specifies the VMs that will be created when executing ```vagrant up```.
- ```vagrant_ansible_inventory``` which specifies the groups of VMs that will be provisioned by ansible.

Note: please make sure that the host machine has enough resources to run all VMs.
