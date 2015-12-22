#!/bin/bash

ANSIBLE_DIR="/etc/ansible"
ANSIBLE_HOSTS="$ANSIBLE_DIR/hosts"

echo "Did you add the new host(s) to $ANSIBLE_HOSTS? [Y/n] "
read ANSWER

# process $ANSWER here




ansible all -b --become-user=root -a 'yum -y update'
ansible all -b --become-user=root -a 'yum install -y nmap lynx wget curl bind-utils whois vim tcpdump mtr iperf iotop htop screen'
ansible all -b --become-user=root -a 'yum -y update'
ansible all -b --become-user=root -a 'yum clean all'
ansible-playbook -b --become-user=root configs/roles/all_servers.cfg

echo "You probably want to reboot any new VMs"
