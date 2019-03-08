# */
FROM centos:centos6.9

MAINTAINER wujian@wujian360.cn "Please don't change yourself"

COPY mariadb.repo /etc/yum.repos.d/mariadb.repo

RUN yum install -y httpd php php-mysql gcc libffi-devel python-devel python-setuptools openssl-devel MariaDB MariaDB-client MariaDB-server MariaDB-devel unzip net-snmp* && yum clean all && rm -rf /var/lib/mysql

COPY lepus_3.8 /lepus

RUN cd /lepus/MySQLdb1-master/ && python setup.py build && python setup.py install && cd /lepus/pymongo-2.7/ && python setup.py install && cd /lepus/redis-2.10.3/ && python setup.py install

RUN unzip /lepus/Lepus_3.8.zip && chmod +x /Lepus_v3.8_beta/python/install.sh && chmod +x /lepus/run.sh && cd /Lepus_v3.8_beta/python && sh install.sh 

RUN cp -ap /Lepus_v3.8_beta/php/* /var/www/html/.

RUN chmod +x /lepus/config.sh && sh /lepus/config.sh

CMD ["/lepus/run.sh"]
