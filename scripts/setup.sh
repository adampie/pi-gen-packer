#!/bin/bash

echo "Making Vagrant sudo with NOPASSWD"
sudo echo %vagrant ALL=NOPASSWD:ALL > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant

echo "Install VirtualBox Guest"
sudo apt-get install -y linux-headers-$(uname -r) build-essential virtualbox-guest-dkms

echo "Setting up Vagrant keys"
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh

echo "Clean up"
sudo apt-get -y autoremove
sudo apt-get -y clean

echo "Setting up Ansible"
sudo apt-get install -y python-setuptools python-dev gcc libssl-dev
sudo easy_install pip
sudo pip install ansible

echo "Removing VBoxGuest*"
rm /home/vagrant/VBoxGuest*

echo "Zeroing disk"
dd if=/dev/zero of=/EMPTY bs=1M || true; sync; sleep 1; sync
rm -f /EMPTY; sync; sleep 1; sync
