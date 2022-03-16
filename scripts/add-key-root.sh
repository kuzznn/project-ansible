#!bin/sh
yum update -y 

yum install openssh-server -y

sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

systemctl start sshd 

useradd -m -s /bin/bash nam

./keys/id_rsa.pub /home/nam/.ssh/authorized_keys
chown -R nam:nam /home/nam/.ssh
chmod 600 /home/nam/.ssh/authorized_keys