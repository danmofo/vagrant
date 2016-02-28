#!/usr/bin/env bash

# This script runs once the machine is first created
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

echo "Running main bootstrap script."

# Setup environment
echo "Setting up environment.."
echo "Copying .bash_aliases to ~/.bash_aliases"
sudo cp /vagrant/dotfiles/.aliases ~/.bash_aliases
echo "Copying .bashrc to ~/.bashrc"
sudo cp /vagrant/dotfiles/.bashrc ~/.bashrc
source ~/.bashrc
echo "Copying hosts file to /etc/hosts"
sudo cp /vagrant/hosts/guest_hosts /etc/hosts 

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

# Add Java to /usr/bin
echo "Setting Java version to 1.7.."
#sudo update-alternatives --config java


# Enable Apache mods
sudo a2enmod proxy proxy_http

# Open ports and enable firewall
sudo ufw allow http
sudo ufw allow ssh
sudo ufw --force enable

# Remove default Apache configuration and use our own
sudo rm /etc/apache2/sites-enabled/000-default
sudo ln -s /vagrant/apache2/development /etc/apache2/sites-enabled/

echo "All done!"