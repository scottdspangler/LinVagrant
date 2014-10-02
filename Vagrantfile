Vagrant.require_plugin('vagrant-linode')

Vagrant.configure('2') do |config|

  # Auth
  config.ssh.username         = 'bootstrap'
  config.ssh.private_key_path = './test_id_rsa'

  config.vm.provider :linode do |provider, override|
    override.vm.box           = 'linode'
    override.vm.box_url       = 'https://github.com/displague/vagrant-linode/raw/master/box/linode.box'
    provider.token            = ENV['LINODE_TOKEN']
    provider.ssh_key_name     = 'Test Key'
  end

  # Provisioning
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.provision :shell, path: 'scripts/provision.sh'

  config.vm.provision :puppet do |puppet|
    puppet.options            = "--verbose --debug"
    puppet.manifest_file      = "site.pp"
    puppet.manifests_path     = "./puppet/manifests"
    puppet.module_path        = "./puppet/modules"
    puppet.working_directory  = "/vagrant"
  end

  # Linodes 
  config.vm.define :ubuntu do |ubuntu|
    ubuntu.vm.provider :linode do |provider|
      provider.datacenter       = 'newark'
      provider.distribution     = 'Ubuntu 14.04 LTS'
      provider.plan             = '1024'
      provider.xvda_size        = '2048'
      provider.swap_size        = '256'
    end
  end

end
