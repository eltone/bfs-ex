# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.provision "shell", inline: <<-SHELL
    wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb

    sudo apt-get update
    sudo apt-get install -y esl-erlang elixir
    sudo locale-gen en_GB.UTF-8

    rm erlang-solutions_1.0_all.deb
  SHELL
end
