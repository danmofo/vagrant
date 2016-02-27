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
cp /vagrant/dotfiles/.aliases ~/.bash_aliases
cp /vagrant/dotfiles/.bashrc ~/.bashrc
source ~/.bashrc

# Install updates
echo $env
echo "Running updates.."
sudo apt-get update -qq

cd $__ROOT

# Copy hosts file
echo "Coping hosts file to /etc/hosts.."
sudo cp /vagrant/hosts/guest_hosts /etc/hosts 

# Download some packages from external sources
echo "Downloading Apache Tomcat 8.."
wget http://mirror.catn.com/pub/apache/tomcat/tomcat-8/v8.0.32/bin/apache-tomcat-8.0.32.tar.gz -O /vagrant/setup/tomcat8.tar.gz
cd /vagrant/setup
tar -xvzf tomcat8.tar.gz -C /vagrant/server

echo "Installing packages.."

# Install needed packages
sudo apt-get install -yqq openjdk-7-jdk
sudo apt-get install -yqq maven
sudo apt-get install -yqq apache2
sudo apt-get install -yqq curl

# Enable Apache mods
sudo a2enmod proxy proxy_http

# Open ports and enable firewall
sudo ufw allow http
sudo ufw allow ssh
sudo ufw --force enable

# Remove default Apache configuration and use our own
sudo rm /etc/apache2/sites-enabled/default-000
sudo ln -s /vagrant/apache2/development /etc/apache2/sites-enabled/

echo "All done!"