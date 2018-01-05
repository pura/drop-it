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
RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
# install nginx
RUN yum -y install nginx --nogpgcheck

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

RUN rm /etc/nginx/conf.d/default.conf
ADD site.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 8080

CMD ["nginx", "-g", "daemon off;"]