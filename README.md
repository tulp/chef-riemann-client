# Description

This Cookbook adds the riemann-client (via gem) and installs the selected checks for : 
- Riemann-Health
- Riemann-Nova (nova-manage service list)
- Riemann-Fixed (nova-manage fixed list)
- Riemann-KVMInstances

All checks are daemonized and integrated via runit and/or ruby-daemonize 

Usage
===================
For Chef-Server:
Just deploy recipes for nodes and create at least one riemann-server via cookbook
(the clients find the ip of the server trough the node deployed with riemann-server recipe)

For Chef-Solo:
Adjust the paths to your environment and boot vagrant machines in combination with riemann-server

# Requirements

## Platform:

* Centos (>= 6.4)
* Ubuntu

## Cookbooks:

* runit
* rbenv

# Attributes

* `node['riemann']['tools_version']` - . Defaults to `0.1.3`.
* `node['riemann']['client_version']` - . Defaults to `0.2.2`.
* `node['riemann']['ruby_version']` - . Defaults to `1.9.3-p286`.
* `node['riemann']['ruby_shebang']` - . Defaults to `#!/opt/rbenv/shims/ruby`.
* `node['riemann']['ruby_exec']` - . Defaults to `/opt/rbenv/shims/ruby`.

# Recipes

* riemann-client::default - Installs the riemann-client (gem) and adds a user for `riemann`
* riemann-client::tools - Configures the riemann-tools (gem), a dependency of health and net
* riemann-client::health - Installs the health monitor
* riemann-client::net - Installs the net monitor
* riemann-client::nova - Installs a custom (bundled) Nova services monitor
* riemann-client::kvm - Installs a custom (bundled) KVM monitor
* riemann-client::fixed - Installs a custom (bundled) fixed IP monitor

# License and Maintainer

Maintainer:: cloudbau GmbH (<h.volkmer@cloudbau.de>)

License:: Apache v2.0
