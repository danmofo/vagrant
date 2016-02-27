# documentation: https://docs.vagrantup.com
Vagrant.configure(2) do |config|

  config.vm.box = "hashicorp/precise64"

  config.vm.network "forwarded_port", guest: 80, host: 8888
  config.vm.network "private_network", type: "dhcp", ip: "172.28.128.11"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end
  
  # The path is a git repository / Eclipse workspace, allowing development to be done directly on the VM.
  # Since this project is a git repository itself, it's assumed all Git repositories are in the same location on the local machine
  config.vm.synced_folder "../spring-tutorial-51", "/vagrant/applications/offers"

  config.vm.provision "shell", path: "scripts/bootstrap.sh"
  config.vm.provision "shell", path: "scripts/always.sh", run: "always"
end
