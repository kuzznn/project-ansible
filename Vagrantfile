# -*- mode: ruby -*-
# vi: set ft=ruby :
# Use config.yaml for basic VM configuration.

require 'yaml'
dir = File.dirname(File.expand_path(__FILE__))
config_nodes = "#{dir}/config/config_multi-nodes.yaml"

if !File.exist?("#{config_nodes}")
  raise 'Configuration file is missing! Please make sure that the configuration exists and try again.'
end
vconfig = YAML::load_file("#{config_nodes}")

BRIDGE_NET = vconfig['vagrant_ip']
DOMAIN = vconfig['vagrant_domain_name']
RAM = vconfig['vagrant_memory']
PUBKEY = vconfig['ssh_key_pub']
servers=[
  {
    :hostname => "nginx." + "#{DOMAIN}",
    :ip => "#{BRIDGE_NET}" + "10",
    :ram => 1024
   } 
  # {
  #   :hostname => "mysql." + "#{DOMAIN}",
  #   :ip => "#{BRIDGE_NET}" + "20",
  #   :ram => "#{RAM}" 
  # },
  # {
  #   :hostname => "php." + "#{DOMAIN}",
  #   :ip => "#{BRIDGE_NET}" + "30",
  #   :ram => "#{RAM}" 
  # }
  # # 
  # #   :hostname => "ansible." + "#{DOMAIN}",
  # #   :ip => "#{BRIDGE_NET}" + "10",
  # #   :ram => "#{RAM}",
  #   # :install_ansible => "./artefacts/scripts/install_ansible_centos.sh", 
    
  #   # :config_ansible => "./artefacts/scripts/config_ansible.sh",
  #   # :source =>  "./artefacts/.",
  #   # :destination => "/home/vagrant/"
  # 
]
$script = <<-SCRIPT
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
SCRIPT
Vagrant.configure(2) do |config|
  config.vm.provision "shell", inline: <<-SHELL
    touch /home/vagrant/.ssh/authorized_keys 
    echo #{PUBKEY} >> /home/vagrant/.ssh/authorized_keys
  SHELL
  config.vm.synced_folder ".", vconfig['vagrant_directory'], :mount_options => ["dmode=777", "fmode=666"]
    servers.each do |machine|
      config.vm.define machine[:hostname] do |node|
      node.vm.box = vconfig['vagrant_box']
      node.vm.box_version = vconfig['vagrant_box_version']
      node.vm.hostname = machine[:hostname]
      node.vm.network "private_network", ip: machine[:ip]
      node.vm.provision :shell,inline: $script
      node.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.cpus = vconfig['vagrant_cpu']
        vb.memory = machine[:ram]
        vb.name = machine[:hostname]
        if (!machine[:install_ansible].nil?)
          if File.exist?(machine[:install_ansible])
            node.vm.provision :shell, path: machine[:install_ansible]
          end
          if File.exist?(machine[:config_ansible])
            node.vm.provision :file, source: machine[:source] , destination: machine[:destination]
            node.vm.provision :shell, privileged: false, path: machine[:config_ansible]
          end
        end
      end
    end
    end
end
