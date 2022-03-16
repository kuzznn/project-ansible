FROM centos:latest
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum update -y
RUN yum install make git-core openssh-server passwd -y
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
ENTRYPOINT systemctl ssh start && bash
# RUN pam-auth-update
RUN useradd -m -s /bin/bash nam
COPY ./keys/id_rsa.pub /home/nam/.ssh/authorized_keys
RUN chown -R nam:nam /home/nam/.ssh
RUN chmod 600 /home/nam/.ssh/authorized_keys
EXPOSE 22:2000 3306:3306