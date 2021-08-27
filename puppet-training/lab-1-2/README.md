# Setup Puppet

## Install Puppet Server
```
yum -y update
yum -y install epel-release
yum install -y https://yum.puppet.com/puppet-release-el-8.noarch.rpm
yum install -y puppetserver
```

## Configure Host for puppet
```
echo "127.0.2.1 puppet puppetdb puppet.home" >> /etc/hosts
systemctl enable --now firewalld

firewall-cmd --zone=public --permanent --add-service=http --add-service=https --add-service=ssh
firewall-cmd --zone=public --permanent --add-port 8140/tcp
firewall-cmd --reload
```

## Restart Services
```
systemctl enable puppetserver
systemctl enable puppet
```
 
## Verify Status
```
systemctl status puppetserver
systemctl status puppet
```
