FROM sickp/centos-sshd:latest
RUN usermod -p "!" root
COPY ./keys/namtp.pub /root/.ssh/authorized_keys
COPY ./files/systemctl.py /usr/bin/systemctl
COPY addkey.sh /opt
RUN chmod a+x /usr/bin/systemctl
RUN set sebool -P httpd_can_network_connect 1
EXPOSE 22 80 3306
