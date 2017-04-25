#
# Apache2.4 & PHP7.1
# kunitaya/apache24_php71
#
# 2017-04-24
#   CentOS Linux 7.3.1611
#   Apache 2.4.6
#   PHP 7.0.14

FROM kunitaya/centos.jp
MAINTAINER kunitaya

# update yum
RUN yum makecache fast && \
    yum update -y

# epel,remi
RUN yum install -y epel-release && \
    yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
    sed -i -e "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/epel.repo && \
    sed -i -e "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/remi.repo

# httpd, which
RUN yum install -y httpd httpd-tools which

# php-pecl-memcached
RUN yum install --enablerepo=remi,remi-php71 -y php-pecl-memcached

# php
RUN yum install --enablerepo=epel,remi-php71 -y php php-devel php-gd php-mbstring php-mcrypt php-mysqlnd php-pear php-xml php-opcache && \
    sed -i -e "s/;date.timezone *=.*$/date.timezone = Asia\/Tokyo/" /etc/php.ini

# clear
RUN yum clean all

EXPOSE 80 443
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
