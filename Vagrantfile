# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos63-x64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :hostonly, "192.168.4.3"

  # we're going to need at least one Gig on that box for torquebox !
  config.vm.customize ["modifyvm", :id, "--memory", 1024]

  # Default user/group id for vagrant in precise32
  host_user_id = 1000
  host_group_id = 1000

  if RUBY_PLATFORM =~ /linux|darwin/
    config.vm.share_folder("v-root", "/vagrant", ".", :nfs => true)
    host_user_id = Process.euid
    host_group_id = Process.egid
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ['cookbooks', 'site-cookbooks']
    %w(
      yum::yum
      yum::epel
      tmux::package
      java::openjdk torquebox::default
      mongodb::10gen_repo mongodb::default
    ).each do |recipe|
      chef.add_recipe(recipe)
    end

    chef.json = {
      :torquebox => {
          :version => "2.3.0",
          :user => "torquebox",
          :group => "torquebox",
          :install_path => "/usr/local/torquebox",
      }
    }
  end

end
