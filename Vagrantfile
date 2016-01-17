
Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty32"
  config.vm.define :bikelomatic do |t|
  end
  
  config.ssh.insert_key = false
  config.vm.network "forwarded_port", guest: 80, host: 8080
  
  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
    #vb.gui = true
    vb.memory = "2048"
  end

  config.vm.provision "shell", path: "scripts/bootstrap.sh"
  config.trigger.before :destroy do
    run_remote "bash /vagrant/scripts/cleanup.sh"
  end
  
end
