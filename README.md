Netflix's RSS recipes with Vagrant and Ansible
==============================================

System requirements:
--------------------

- A Linux host machine with at least 12GB RAM
- with the following packages installed:
   - vagrant
   - vagrant hostmanager (by running ```vagrant plugin install vagrant-hostmanager```)
   - virtualbox
   - ansible (>=1.9.3)

How to setup and run the application:
-------------
0. Clone this repository
0. Inside the cloned repository, run ```git submodule init``` and ```git submodule update``` to fetch ```rssrecipes-ansible```
0. Run
```
vagrant up
```.
This step can take up to 20 minutes.
0. Use the application (see below) to generate some activities and log files
0. Stop the application by changing into ```rsscipes-ansible``` directory and running
```
ansible-playbook -i ../.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory -u vagrant stop.yml
```
0. Copy the log files by running
```
ansible-playbook -i ../.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory -u vagrant copy-log.yml
```.
The log files will be copied to ```/tmp/Result``` of the host machine.
0. The log files on the virtual machines can be cleaned by running
```
ansible-playbook -i ../.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory -u vagrant clean.yml
```
0. You may start the application again by running
```
ansible-playbook -i ../.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory -u vagrant -e hardware_platform='emulab' start.yml
```

Using and testing the application:
------------------------
- With the default settings, the RSS reader service can be accessed at ```http://192.168.77.21/jsp/rss.jsp``` from the host machine.
- RSS feeds can be added by entering the URL into the text box. Available URLs are:
   - http://192.168.77.26/feeds/abc.xml
   - http://192.168.77.26/feeds/bbc.xml
   - http://192.168.77.26/feeds/cnn.xml
   - http://192.168.77.26/feeds/dw.xml
   - http://192.168.77.26/feeds/forbes.xml
   - http://192.168.77.26/feeds/reuters.xml
   - http://192.168.77.26/feeds/spiegel.xml
   - http://192.168.77.26/feeds/wsj.xml

Additional addresses can be used to debug the application:
   - edge: http://192.168.77.22:9090/jsp/rss.jsp
   - eureka: http://192.168.77.24/eureka

Architecture of this setup:
---------------------------

    +-------------------------------------------------------------------------------+
    |         .21                 .22                 .23                 .25       |
    |    +------------+      +------------+      +------------+      +------------+ |
    | :80|loadbalancer| :9090|    edge    | :9191| middletier | :9160|  database  | |
    | -->| (machine1) |----->| (machine2) |----->| (machine3) |----->| (machine5) | |
    |    +------------+      +------------+      +------------+      +------------+ |
    |                                \               /    \                         |
    |                                 \             /      \                        |
    |                                  \:80        /:80     \:80                    |
    |                                   \  .24    /          \     .26              |
    |                                 +------------+         +------------+         |
    |                                 |   Eureka   |         | Feed server|         |
    |                                 | (machine4) |         | (machine6) |         |
    |                                 +------------+         +------------+         |
    |                                                                               |
    |                              Virtual machines                                 |
    |                 (created by Vagrant and provisioned by Ansible)               |
    +-------------------------------------------------------------------------------+
    |                                 Virtual Box                                   |
    +-------------------------------------------------------------------------------+
    |                                     Host                                      |
    +-------------------------------------------------------------------------------+
