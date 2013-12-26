# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url  = 'http://files.vagrantup.com/precise64.box'
  config.vm.hostname = 'node-dev-box'
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  #config.vm.network :private_network, ip: "192.168.0.10"
  # config.vm.network :public_network
  # config.ssh.forward_agent = true
  # config.vm.synced_folder "./vagrant_data", "/vagrant_data"

  config.vm.provider :virtualbox do |vb|
    # vb.gui = true
    # vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
  
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.module_path    = 'puppet/modules'
  end

  #config.vm.provision :shell, :inline => "add-apt-repository -y ppa:chris-lea/node.js"
  #config.vm.provision :shell, :inline => "apt-get -q update"
  #config.vm.provision :shell, :inline => "apt-get -yq install nodejs"

  #config.vm.provision :shell, :path => "provision.sh"

end
