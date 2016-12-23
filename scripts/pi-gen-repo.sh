#!/bin/bash

echo "Cloning pi-gen"
cd /home/vagrant
git clone https://github.com/adampie/pi-gen.git

echo "Installing pi-gen dependencies"
cd pi-gen
ansible-playbook dependencies.yml
