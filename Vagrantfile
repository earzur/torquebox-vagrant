# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

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

    chef.add_recipe('apt::default')
    chef.add_recipe('rvm::vagrant')
    chef.add_recipe('rvm::system')
    chef.add_recipe('java::openjdk')
    chef.add_recipe('mongodb::10gen_repo')
    chef.add_recipe('mongodb::default')

    chef.json = {
      :rvm => {
        # force version and branch (see https://github.com/fnichol/chef-rvm/issues/157)
        :version => "1.17.10",
        :branch  => "none",
        :default_ruby => 'ruby-1.9.3-p194',
        :vagrant => {
          :system_chef_solo => '/opt/vagrant_ruby/bin/chef-solo'
        },
        :global_gems => [{ :name => 'bundler'} ]
      }
    }
  end

end
