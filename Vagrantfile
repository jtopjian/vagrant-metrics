VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "dummy"

  # Get homedir
  homedir = File.expand_path('~')

  # SSH
  config.ssh.private_key_path = "#{homedir}/.ssh/id_rsa"

  # Basic OpenStack options
  # Note that an openrc file needs sourced before using
  config.vm.provider :openstack do |os|
    os.username        = ENV['OS_USERNAME']
    os.api_key         = ENV['OS_PASSWORD']
    os.tenant          = ENV['OS_TENANT_NAME']
    os.flavor          = 'm1.small'
    os.image           = 'Ubuntu 14.04'
    os.endpoint        = "#{ENV['OS_AUTH_URL']}/tokens"
    os.keypair_name    = 'metrics'
    os.ssh_username    = 'ubuntu'
    os.security_groups = ['default', 'openstack']
    os.address_id      = 'cybera'
  end

  # Vagrant Hostmanager
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = false

  config.vm.define 'puppet' do |vm|
    vm.vm.hostname = 'puppet.example.com'
    vm.hostmanager.aliases = ['puppet']
    vm.vm.provision 'shell', inline: "echo puppet > /etc/hostname; hostname -F /etc/hostname"
    vm.vm.provision 'shell', path: 'bootstraps/common.sh'
    vm.vm.provision 'shell', inline: "echo role=puppet_master > /etc/facter/facts.d/role.txt"
    vm.vm.provision 'shell', inline: "echo location=yyc > /etc/facter/facts.d/location.txt"
    vm.vm.provision 'shell', path: 'bootstraps/puppetserver.sh'
    vm.vm.provider :openstack do |os|
      os.keypair_name = 'home'
    end
  end

  config.vm.define 'rabbitmq' do |vm|
    vm.vm.hostname = 'rabbitmq.example.com'
    vm.hostmanager.aliases = ['rabbitmq']
    vm.vm.provision 'shell', inline: "echo rabbitmq > /etc/hostname; hostname -F /etc/hostname"
    vm.vm.provision 'shell', path: 'bootstraps/common.sh'
    vm.vm.provision 'shell', inline: "echo role=rabbitmq > /etc/facter/facts.d/role.txt"
    vm.vm.provision 'shell', inline: "echo location=yyc > /etc/facter/facts.d/location.txt"
    vm.vm.provision 'shell', path: 'bootstraps/run_puppet.sh'
  end

  config.vm.define 'sensu' do |vm|
    vm.vm.hostname = 'sensu.example.com'
    vm.hostmanager.aliases = ['sensu']
    vm.vm.provision 'shell', inline: "echo sensu > /etc/hostname; hostname -F /etc/hostname"
    vm.vm.provision 'shell', path: 'bootstraps/common.sh'
    vm.vm.provision 'shell', inline: "echo role=sensu > /etc/facter/facts.d/role.txt"
    vm.vm.provision 'shell', inline: "echo location=yyc > /etc/facter/facts.d/location.txt"
    vm.vm.provision 'shell', path: 'bootstraps/run_puppet.sh'
  end

  config.vm.define 'redis' do |vm|
    vm.vm.hostname = 'redis.example.com'
    vm.hostmanager.aliases = ['redis']
    vm.vm.provision 'shell', inline: "echo redis > /etc/hostname; hostname -F /etc/hostname"
    vm.vm.provision 'shell', path: 'bootstraps/common.sh'
    vm.vm.provision 'shell', inline: "echo role=redis > /etc/facter/facts.d/role.txt"
    vm.vm.provision 'shell', inline: "echo location=yyc > /etc/facter/facts.d/location.txt"
    vm.vm.provision 'shell', path: 'bootstraps/run_puppet.sh'
  end

end
