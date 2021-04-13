require 'yaml'

settings = YAML.load_file 'nodes.yaml'
docker_build_settings = settings['docker-build']

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.define "docker-build" do |config|
      # Set gest host config/spec
      config.vm.box = docker_build_settings['box'] # Set VM OS
      config.disksize.size = '30GB'
      config.vbguest.auto_update = false
      config.vm.hostname = "docker-build"
      config.vm.network :private_network, ip: docker_build_settings['ip']
      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", docker_build_settings['memory']]
        vb.customize ["modifyvm", :id, "--name", "docker-build"]
      end

      # Mount volumes
      config.vm.synced_folder ".", "/vagrant",  :mount_options => ["dmode=777,fmode=777"]
      docker_build_settings['artifacts_dir'].each do |artifact_dir|
          config.vm.synced_folder artifact_dir['host'], artifact_dir['guest'],  :mount_options => ["dmode=777,fmode=777"]
      end

      # Run the provisioner/preparation scripts
      ## Set git config
      config.vm.provision "file", source: docker_build_settings['git_ssh_key_path'], destination: "/tmp/id_rsa"
      config.vm.provision "shell", inline: "mv /tmp/id_rsa /home/vagrant/.ssh/id_rsa"

      ## Setting env vars
      docker_build_settings['env_var'].each do |var|
          config.vm.provision :shell, inline: "echo \"export ${VAR_KEY}=${VAR_VALUE}\" >> /home/vagrant/.profile; ln -fs /home/vagrant/.profile /root/.profile",
          env: {
              "VAR_KEY" => var.keys.first,
              "VAR_VALUE" => var.values.first,
          }
      end

      ## Installing the required packages
      config.vm.provision :shell, :path => docker_build_settings['bootstrap']

      ## Reboot after provisioning
      config.trigger.after :up do |trigger|
        trigger.name = "Reboot after provisioning"
        trigger.run = { :inline => "vagrant reload" }
      end

    end
end
