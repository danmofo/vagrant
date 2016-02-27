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
cp /vagrant/dotfiles/.aliases ~/.bash_aliases
cp /vagrant/dotfiles/.bashrc ~/.bashrc
source ~/.bashrc

cd $__ROOT

# Add aliases to guest machine


# Install updates
sudo apt-get update

# Copy hosts file
sudo cp $HOME/hosts/guest_hosts /etc/hosts 

# Download some packages from external sources
wget http://mirror.catn.com/pub/apache/tomcat/tomcat-8/v8.0.32/bin/apache-tomcat-8.0.32.tar.gz -O $SETUPDIR/tomcat8.tar.gz
cd $SETUPDIR
tar -xvzf tomcat8.tar.gz -C $SERVERDIR

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
sudo ln -s $__ROOT/apache2/development $APACHEDIR/sites-enabled/