#!/bin/bash -x

apt-get -y update
apt-get -y upgrade
# apt-get -y install gcc build-essential linux-headers-$(uname -r)
# apt-get -y install zlib1g-dev libssl-dev libreadline-gplv2-dev libyaml-dev
apt-get -y install fail2ban
# apt-get -y install tiger
apt-get -y install vim curl

# secure shared memory
echo "tmpfs     /dev/shm     tmpfs     defaults,noexec,nosuid     0     0" >> /etc/fstab

# backup sshd_config, set to readonly
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.factory-defaults
chmod a-w /etc/ssh/sshd_config.factory-defaults

# configure /etc/ssh/sshd_config
cp /tmp/basebox_sshd_config /etc/ssh/sshd_config
chmod 0644 /etc/ssh/sshd_config

# Limit use of su to admins
dpkg-statoverride --update --add root admin 4750 /bin/su

# harden network with sysctl settings
# disable Open DNS Recursion and Remove Version info - BIND DNS Server
# prevent IP spoofing
cp /tmp/issue.net /etc/issue.net
