# -*- mode: ruby -*-
# vi: set ft=ruby :

################################################################################
# Google Cloud configuration.  Create a configuration file by copying
# google.rb-sample to google.rb and setting appropriate values.
################################################################################
GOOGLE_CONFIG = "./google.rb"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/bionic64"
  config.vm.provider :google do |google, override|
    override.vm.box = "google/gce"
  end

  # Forward ssh keys
  config.ssh.forward_agent = true

  # Forward port tcp/3000 from the guest to the host
  #config.vm.network "forwarded_port", guest: 3000, host: 3000

  # Local files to vm
  config.vm.provision "file", source: "~/.aws", destination: "$HOME/.aws"
  config.vm.provision "file", source: "~/.gitconfig", destination: "$HOME/.gitconfig"
  config.vm.provision "file", source: "~/.ssh/id_ed25519.pub", destination: "$HOME/.ssh/id_ed25519.pub"
  config.vm.provision "file", source: "~/.ssh/id_ed25519", destination: "$HOME/.ssh/id_ed25519"
  config.vm.provision "file", source: "~/.ssh/config", destination: "$HOME/.ssh/config"
  config.vm.provision "file", source: "~/.vim", destination: "$HOME/.vim"
  config.vm.provision "file", source: "~/.vimrc", destination: "$HOME/.vimrc"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end

  # Google GCE
  # https://github.com/mitchellh/vagrant-google
  config.vm.provider :google do |google, override|
    if File.exist?(GOOGLE_CONFIG)
      require GOOGLE_CONFIG
    end
    # GCP credentials
    google.google_project_id = $google_project_id
    google.google_json_key_location = $google_json_key_location

    # GCE instance settings
    google.image_family = $google_image_family
    google.machine_type = $google_machine_type
    google.disk_type = $google_disk_type
    google.disk_size = $google_disk_size
    google.autodelete_disk = true
    google.preemptible = $google_preemptible
    if $google_preemptible
      # these must be set to these values for preemptible GCE instances
      google.auto_restart = false
      google.on_host_maintenance = "TERMINATE"
    else
      google.auto_restart = true
      google.on_host_maintenance = "MIGRATE"
    end

    # SSH key
    #override.ssh.username = "vagrant"
    override.ssh.private_key_path = $ssh_private_key_path

    # Tags
    google.tags = [
      "vagrant"
    ]
  end


  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "local.yml"
  end
end
