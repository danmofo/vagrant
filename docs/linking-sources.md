Linking applications from local environment to virtual machine environment
===

I'm sure there are more efficient ways of doing this...this seems like too much work. 

1. SSH into the virtual machine (`vagrant ssh`). Go to the project directory root (where `pom.xml` exists), run `mvn dependency:copy-dependencies`, this will put the dependencies for that project inside `target/dependency`. You will need to do this for each project. todo: write a script to automate these last steps into running one script
2. Run `link.sh` (`/vagrant/scripts/link.sh`, this will link all project sources to Tomcat's `webapps` directory.
3. Restart Tomcat, `sudo service tomcat7 restart`.
4. All of your configured applications should now be accessible and running (check each app is running with `curl 'http://localhost:8080/path/to/context'`.
