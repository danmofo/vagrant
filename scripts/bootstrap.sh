#!/usr/bin/env bash

# This script runs once the machine is first created, it may take a while.
# 
# todo:
# - setup shared folder for local development using git repository
# - add key authentication only
# - add ssh key
# - add ssl cert
# - install other software
#   - mysql
#   - elasticsearch
# - explore work build scripts
# - environment variables: https://www.vagrantup.com/docs/provisioning/shell.html

# Setup environment
echo "Setting up environment.."
echo "Copying .bash_aliases to ~/.bash_aliases"
sudo cp /vagrant/dotfiles/.aliases ~/.bash_aliases
echo "Copying .bashrc to ~/.bashrc"
sudo rm ~/.bashrc
sudo cp /vagrant/dotfiles/.bashrc ~/.bashrc
. ~/.bashrc
. ~/.bash_aliases
echo "Copying hosts file to /etc/hosts"
sudo cp /vagrant/hosts/guest_hosts /etc/hosts 

# Clear out existing folder structure (since /vagrant/ is shared, it's not cleared each time we destroy the machine)
# todo: change environment heavily so it's not based out of this shared folder
echo "cleaning out older shared folders..."
sudo rm -rf /vagrant/server
sudo rm -rf /vagrant/setup
sudo rm -rf /vagrant/private

# /vagrant/applications is created automatically by the folder share!

# Create a fresh directory structure
if [ ! -d "/vagrant/setup" ]; then
	mkdir /vagrant/setup
	mkdir /vagrant/private
	mkdir /vagrant/server
fi

# Install updates
echo "Running updates.."
sudo apt-get -qq update

# Download some packages from external sources
if [ ! -d "/vagrant/server/apache*"]; then
	echo "Can't find Apache directory. Downloading Apache Tomcat 8.."
	wget http://mirror.catn.com/pub/apache/tomcat/tomcat-8/v8.0.32/bin/apache-tomcat-8.0.32.tar.gz -O /vagrant/setup/tomcat8.tar.gz
	cd /vagrant/setup
	tar -xvzf tomcat8.tar.gz -C /vagrant/server
fi

# Install Java, Maven, Apache and curl
echo "Installing packages.."
sudo apt-get install -yqq openjdk-7-jdk
sudo apt-get install -yqq maven
sudo apt-get install -yqq apache2
sudo apt-get install -yqq curl
sudo apt-get install -yqq dos2unix

# Add Java to /usr/bin
echo "Setting Java version to 1.7.."
sudo rm /usr/bin/java
sudo ln -s /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java /usr/bin

# Enable Apache mods
sudo a2enmod proxy proxy_http

# Open ports and enable firewall
sudo ufw allow http
sudo ufw allow ssh
sudo ufw --force enable

# Remove default Apache configuration and use our own
sudo rm /etc/apache2/sites-enabled/000-default
sudo ln -s /vagrant/apache2/development /etc/apache2/sites-enabled/

echo "All done! Run /vagrant/scripts/link.sh to link project sources to Tomcat / Apache!"