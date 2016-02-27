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

# Install updates
sudo apt-get update

# Install needed packages
sudo apt-get install -y apache2
sudo apt-get install -y tomcat7
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