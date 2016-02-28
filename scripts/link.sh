#!/usr/bin/env bash

# Links each application's Java sources to Tomcat's webapps directory
# as well as configuring each application for use in Tomcat.

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