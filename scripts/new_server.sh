#!/bin/bash

ANSIBLE_DIR="/etc/ansible"
ANSIBLE_HOSTS="$ANSIBLE_DIR/hosts"

if [ ! -d $ANSIBLE_DIR ]; then
    echo "ansible directory $ANSIBLE_DIR not found"
    exit 0
fi

if [ ! -r $ANSIBLE_HOSTS ]; then
    echo "Can't read ansible hosts file $ANSIBLE_HOSTS"
    exit 0
fi

if [ "$(pwd)" != "/etc/ansible" ]; then
    echo "Script must be ran from /etc/ansible"
    exit 0
fi

if [ "$USER" != "discore" ]; then
    echo "Must be run as user discore"
    exit 0
fi

echo -n "Did you add the new host(s) to $ANSIBLE_HOSTS? [Y/n] "
read -r ANSWER

# process $ANSWER here
if [ "$ANSWER" == "n" ] || [ "$ANSWER" == "N" ]; then
    echo "Exiting!"
    exit 0
fi

echo "Running ansible on all hosts in 5 seconds!"
sleep 5

ansible all -b --become-user=root -a 'yum -y update'
ansible all -b --become-user=root -a 'yum install -y nmap lynx wget curl bind-utils whois vim tcpdump mtr iperf iotop htop screen'
ansible all -b --become-user=root -a 'yum clean all'
ansible-playbook -b --become-user=root configs/roles/all.cfg
ansible-playbook -b --become-user=root configs/roles/web.cfg

echo "You probably want to reboot any new VMs..."
