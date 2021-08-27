# déploiement du client
vagrant up client-1 --no-provision

# Install puppet on client from puppet master with Puppet Bolt
```
#Master
yum -y install puppet-bolt
bolt command run 'ip a' -t 192.168.99.11 -u vagrant -p vagrant --no-host-key-check --run-as root
bolt command run 'yum -y update' -t 192.168.99.11 -u vagrant -p vagrant --no-host-key-check --run-as root
bolt command run 'yum -y install epel-release' -t 192.168.99.11 -u vagrant -p vagrant --no-host-key-check --run-as root
bolt command run 'yum -y install puppet' -t 192.168.99.11 -u vagrant -p vagrant --no-host-key-check --run-as root
bolt command run "echo '192.168.99.10 puppet' >> /etc/hosts" -t 192.168.99.11 -u vagrant -p vagrant --no-host-key-check --run-as root
bolt command run "systemctl enable --now puppet" -t 192.168.99.11 -u vagrant -p vagrant --no-host-key-check --run-as root
```

# Verify status on client-1
```
#Client
systemctl status puppet
```

# Configure Agent
```
#Master
puppetserver ca list
puppetserver ca sign --all
```

# Test Module from master
```
#Client
puppet agent -t
```

# Configure dev environment
```
#Master
cp -Rf /etc/puppetlabs/code/environments/production /etc/puppetlabs/code/environments/dev
vi /etc/puppetlabs/code/environments/dev/modules/nginx/templates/content.epp #Add "DEV" in file

#Client
puppet config set environment dev --section=agent
puppet agent -t
curl http://192.168.99.11
```
