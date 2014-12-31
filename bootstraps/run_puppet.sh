#!/bin/bash

echo " ===> Installing Puppet"
apt-get install -y puppet

echo " ===> Configure Puppet"
sed -i '/templatedir/d' /etc/puppet/puppet.conf
puppet config set --section main parser future
puppet config set --section main evaluator current
puppet config set --section main ordering manifest

echo " ===> Running Puppet"
FQDN=$(facter fqdn)
ssh root@puppet.example.com "puppet cert clean ${FQDN}"
ssh root@puppet.example.com "puppet node deactivate ${FQDN}"
puppet agent -t
ssh root@puppet.example.com "puppet cert sign ${FQDN}"
puppet agent -t
puppet agent -t

exit 0
