#!/usr/bin/env bash


echo "LXD setup running as $(whoami)"

#
# UPDATE SYSTEM
#
echo "updating system..."
sudo apt-get update -y
sudo apt-get dist-upgrade -y
echo "... DONE!"

#
# INSTALL BASE PACKAGES (CURL...)
#
if ! which curl 2>&1 > /dev/null; then 
	echo "installing curl..."
	sudo apt-get install -y curl #apt-transport-https ca-certificates software-properties-common
	echo "... DONE!"
fi

if ! which jq 2>&1 > /dev/null; then 
	echo "installing jq..."
	sudo apt-get install -y jq #apt-transport-https ca-certificates software-properties-common
	echo "... DONE!"
fi

if ! which snap 2>&1 > /dev/null; then
	echo "installing snapd..."
	sudo apt-get install -y snapd
	echo "... DONE!"
fi

if ! which juju 2>&1 > /dev/null; then
	echo "installing juju..."
	sudo snap install juju --classic
	sudo apt-get install -y -t xenial-backports lxd
	sudo apt-get install -y zfsutils-linux
	sudo adduser vagrant lxd
	newgrp lxd
	groups
	echo "... DONE!"
fi

sudo lxd init --auto

lxc network get lxdbr0 ipv4.address

juju bootstrap localhost lxd-test

juju controllers

