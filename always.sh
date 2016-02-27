# This script runs each time the virtual machine is booted
# todo: find the equivalent in Linux (boot things on startup / restart)

# Update if required
sudo apt-get update

# Start Apache HTTP server and Apache Tomcat
sudo service tomcat7 start
sudo service apache2 restart