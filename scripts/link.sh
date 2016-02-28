#!/usr/bin/env bash

# Links each application's Java sources to Tomcat's webapps directory
# as well as configuring each application for use in Tomcat.

# This script should only be ran once, after that everything should be hooked up to Eclipse
# and changes should be picked up through the shared folders.

# For some reason the environment variables are not kept from bootstrap.sh..I don't know why.
# Make sure our variables / aliases are available
sudo cp /vagrant/dotfiles/.aliases $HOME/.bash_aliases
sudo cp /vagrant/dotfiles/.bashrc $HOME/.bashrc
. $HOME/.bash_aliases
. $HOME/.bashrc

echo env | grep tomcat

LOCALAPPDIR=/vagrant/applications/offers
TOMCATAPPDIR=$TOMCATDIR/webapps/offers

echo "Linking sources to Tomcat.."

if [ ! -d "$TOMCATAPPDIR" ]; then
	echo "No app directory found, creating.."
	sudo mkdir -p $TOMCATAPPDIR/WEB-INF/
fi

echo "Getting project dependencies from Maven.."
cd $LOCALAPPDIR
mvn dependency:copy-dependencies

sudo ln -s target/dependency $TOMCATAPPDIR/WEB-INF/lib
echo "Dependencies linked to /lib/.."

echo "Linking classes and /WEB-INF/.."
sudo ln -s $LOCALAPPDIR/target/classes $TOMCATAPPDIR/WEB-INF/
sudo ln -s $LOCALAPPDIR/WebContent/WEB-INF/resources $TOMCATAPPDIR/WEB-INF/
sudo ln -s $LOCALAPPDIR/WebContent/WEB-INF/templates $TOMCATAPPDIR/WEB-INF/
sudo ln -s $LOCALAPPDIR/WebContent/WEB-INF/offers-servlet.xml $TOMCATAPPDIR/WEB-INF/
sudo ln -s $LOCALAPPDIR/WebContent/WEB-INF/web.xml $TOMCATAPPDIR/WEB-INF/

echo "All done! Linked /WEB-INF/ folder structure below: "
ls -all $TOMCATAPPDIR/WEB-INF

echo "Application directory structure: "
ls -all $TOMCATAPPDIR/