# documentation: https://docs.vagrantup.com
Vagrant.configure(2) do |config|

  config.vm.box = "hashicorp/precise64"

  config.vm.network "forwarded_port", guest: 80, host: 8888
  config.vm.network "private_network", type: "dhcp", ip: "172.28.128.11"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  config.vm.provision "shell", path: "bootstrap.sh"
  config.vm.provision "shell", path: "always.sh", run: "always"
end
