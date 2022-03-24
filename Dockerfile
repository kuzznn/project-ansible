FROM sickp/centos-sshd:latest
RUN usermod -p "!" root
COPY ./keys/namtp.pub /root/.ssh/authorized_keys
COPY systemctl.py /usr/bin/systemctl
COPY addkey.sh /opt
RUN chmod a+x /usr/bin/systemctl
RUN set sebool -P httpd_can_network_connect 1
RUN yum install epel-release -y
RUN yum install sudo systemctl nginx python3 mariadb mariadb-server -y
RUN chown -R nginx:nginx /var/www
RUN chown -R nginx:nginx /usr/share/nginx
EXPOSE 22:2345 80:80 3306:3306
