Netflix's RSS recipes with Vagrant and Ansible
==============================================

How to setup and run the application:
-------------
0. Clone this repository
0. Inside the cloned repository, run ```git submodule init``` and ```git submodule update``` to fetch ```rssrecipes-ansible```
0. Run ```vagrant up```

Using and testing the application:
------------------------
- With the default settings, the RSS reader service can be accessed at ```http://192.168.77.21/jsp/rss.jsp```.
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

System requirements:
--------------------

- Linux machine with at least 12GB RAM
- with following packages installed:
   - vagrant
   - vagrant hostmanager: ```vagrant plugin install vagrant-hostmanager```
   - virtualbox
   - ansible (>=1.9.3)
