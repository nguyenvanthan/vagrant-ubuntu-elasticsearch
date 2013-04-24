# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.define :devbox do |devbox|
    devbox.vm.box = "ubuntu-12.10-x64"
    devbox.vm.box_url = "http://24-hetzner.berlinonline.de/boxes/ubuntu-12.10-x64.box"

    devbox.vm.customize ["modifyvm", :id, "--rtcuseutc", "on"] # use UTC clock instead of host clock, see https://github.com/mitchellh/vagrant/issues/912
    devbox.vm.customize ["modifyvm", :id, "--name", "elasticsearch-devbox"]
    #devbox.vm.customize ["modifyvm", :id, "--memory", 1024]
    devbox.vm.network :hostonly, "33.33.33.10"
    devbox.vm.host_name = "elasticsearch.dev"
    devbox.vm.forward_port 9200, 9200

    devbox.ssh.forward_agent = true

    devbox.vm.provision :shell, :inline => "apt-get update --fix-missing"
    
    devbox.vm.provision :puppet do |puppet|
      puppet.manifests_path = "./"
      puppet.manifest_file = "manifest.pp"
      puppet.module_path = "modules"
      #puppet.options = "--verbose --debug"
    end

  end

end
