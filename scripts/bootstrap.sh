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

# Setup environment
sh env.sh

# Install updates
sudo apt-get update

# Copy hosts file
sudo cp guest_hosts /etc/hosts 

# Add aliases to guest machine
source .aliases

# Download some packages from external sources
wget -O http://mirror.catn.com/pub/apache/tomcat/tomcat-8/v8.0.32/bin/apache-tomcat-8.0.32.tar.gz $SETUPDIR/tomcat8.tar.gz
cd $SETUPDIR tar -xvzf tomcat8.tar.gz -C $SERVERDIR

# Install needed packages
sudo apt-get install -y openjdk-7-jdk
sudo apt-get install -y maven
sudo apt-get install -y apache2
sudo apt-get install -y curl


# Enable Apache mods
sudo a2enmod proxy proxy_http

# Open ports and enable firewall
sudo ufw allow http
sudo ufw allow ssh
sudo ufw --force enable

# Remove default Apache configuration and use our own
sudo rm /etc/apache2/sites-enabled/*
sudo ln -s /vagrant/development /etc/apache2/sites-enabled/