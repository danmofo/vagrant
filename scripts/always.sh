# This script runs each time the virtual machine is booted
# todo: find the equivalent in Linux (boot things on startup / restart)

echo "Running the always script."

# Update if required
sudo apt-get -yy update 

# Start Apache HTTP server and Apache Tomcat
sudo service apache2 restart