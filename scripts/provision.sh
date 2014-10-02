#!/bin/bash
#
# Initial Bootstrap, pull in puppet
#


echo "Puppet bootstrapping on `ip a s eth0 | grep 'inet ' | cut -f6 -d ' ' | cut -f1 -d'/'`"

apt-get update -y
apt-get install -y puppet


