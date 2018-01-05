FROM centos:7

# update yum
RUN yum -y update --nogpgcheck; yum clean all
RUN yum -y install yum-utils
# Install some must-haves
RUN yum -y install epel-release --nogpgcheck
RUN yum -y groupinstall "Development Tools"
RUN yum -y install wget --nogpgcheck
RUN yum -y install git --nogpgcheck
RUN yum -y install vim --nogpgcheck
# install remi repo
RUN wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN rpm -Uvh remi-release-7*.rpm
RUN yum-config-manager --enable remi-php70

# install php7 # breaking it down to see where dockerhub dies.
RUN \
    yum -y install \
    php php-common \
    php-mbstring \
    php-mcrypt \
    php-devel \
    php-xml \
    php-mysqlnd \
    php-pdo \
    php-opcache --nogpgcheck \
    php-bcmath \
    php-pecl-memcached \
    php-pecl-mysql \
    php-pecl-xdebug \
    php-pecl-zip \
    php-soap \
    php-pecl-amqp --nogpgcheck \

    || true

# php-fpm
RUN yum -y install php-fpm

#apc installation
RUN yum install -y php-pecl-apcu

# Install composer
RUN curl -sS http://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN sed -i "s/memory_limit = 128M/memory_limit = 256M /g" /etc/php.ini

#Log Dir creation
RUN chmod -R 777 /var/lib/php
RUN chown apache:apache -R /var/lib/php

ADD log.conf /usr/local/etc/php-fpm.d/zz-log.conf
ADD php-fpm.conf /etc/php-fpm.d/www.conf

EXPOSE 9000

CMD ["php-fpm", "-F"]

WORKDIR /var/www/html/drop-it