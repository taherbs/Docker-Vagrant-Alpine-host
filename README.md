# Vagrant Alpine Docker VM

A Vagrant environment to deploy docker/docker-compose/git on an alpine base image.<br />
This project is meant to deploy the same development environment regardless of the hosting platform (Windows/macOS/Linux).<br />
This project is meant to have a fully workable and lightweight docker environment. 

## Prerequisites:
### Windows:
* [chocolatey](https://chocolatey.org/install)
* virtualbox 6 - chocolatey
```
choco install virtualbox --version=6.0.16
```
* [vagrant - chocolatey](https://chocolatey.org/packages/vagrant)
* vagrant disksize plugin
```
vagrant plugin install vagrant-disksize
```

### OSX
```bash
# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Once installed
brew doctor
brew update
# Install Virtual Box Cask
brew cask install virtualbox
# brew cask install vagrant
brew cask install vagrant
# vagrant disksize plugin
vagrant plugin install vagrant-disksize
```

## Configure Vagrant guest host

You can configure the Vagrant guest vm by editing the *nodes.yaml*s.
Duplicate the [nodes.yaml.sample](./nodes.yaml.sample) or rename it into *nodes.yaml* than set params according to your system.

## Usage:

Provision the VM and ssh it:
*NOTE*: *On Windows run your PowerShell terminal as administrator*

```bash
vagrant up
vagrant ssh
```

## Useful commands:

```bash
vagrant destroy #delete the VM, and you will lose all work on the instance
vagrant up      #create a VM
vagrant suspend #suspend the vm
vagrant resume  #resume a suspended vm
```
