# -*- mode: ruby -*-
# vi: set ft=ruby :

def set_hostname(server)
  server.vm.provision 'shell', inline: "hostname #{server.vm.hostname}"
end

Vagrant.configure("2") do |config|
  config.vm.define 'xamarin-jenkins-cake-box' do |n|
    n.vm.box = "http://files.dryga.com/boxes/osx-sierra-0.3.1.box"
    n.vm.hostname = 'xamarin-jenkins-cake-box'
    n.vm.network 'private_network', ip: '192.168.205.30'
    n.vm.synced_folder "install-jenkins/", "/Users/vagrant/install-jenkins", owner: "vagrant", group: "staff",  type: "rsync"
    set_hostname(n)
  end

  config.vm.post_up_message = "You can access Jenkins at http://192.168.205.30:8080"
end
