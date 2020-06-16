# Development Sandbox

A [Vagrant](https://www.vagrantup.com/)-based Ubuntu development sandbox.

## Quick Start

```
# For vanilla virtual machines on your laptop, do this.
vagrant up
vagrant ssh

# For Google Compute Engine machines, do this.
vagrant plugin install vagrant-google
cp google.rb-sample google.rb  # add appropriate values here
vagrant up --provider=google
vagrant ssh
```

## Configuration

The configuration of what languages/packages are installed is set in the `config.yml` file.
