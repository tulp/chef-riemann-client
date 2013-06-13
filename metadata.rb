name              "riemann-client"
maintainer        "cloudbau GmbH"
maintainer_email  "h.volkmer@cloudbau.de"
license           "Apache v2.0"
description       "Installs riemann-client, riemann-tools and some monitor probes"
version           "1.0.0"

supports "centos", ">= 6.4"
supports "ubuntu"

recipe "riemann-client::default", "Installs the riemann-client (gem) and adds a user for `riemann`"
recipe "riemann-client::tools", "Configures the riemann-tools (gem), a dependency of health and net"
recipe "riemann-client::health", "Installs the health monitor"
recipe "riemann-client::net", "Installs the net monitor"
recipe "riemann-client::nova", "Installs a custom (bundled) Nova services monitor"
recipe "riemann-client::kvm", "Installs a custom (bundled) KVM monitor"
recipe "riemann-client::fixed", "Installs a custom (bundled) fixed IP monitor"

depends "runit"
depends "rbenv"

attribute 'riemann/tools_version',
  :display_name => 'version of riemann-tools',
  :type => 'string',
  :default => '0.1.3'

attribute 'riemann/client_version',
  :display_name => 'version of riemann-client',
  :type => 'string',
  :default => '0.2.2'

attribute 'riemann/ruby_version',
  :display_name => 'Ruby version for Riemann dashboard',
  :type => 'string',
  :default => '1.9.3-p286',
  :recipes => [ 'riemann-server::dash' ]

attribute 'riemann/ruby_shebang',
  :display_name => 'Ruby Shebang to use',
  :type => 'string',
  :default => '#!/opt/rbenv/shims/ruby'

attribute 'riemann/ruby_exec',
  :display_name => 'Ruby excutable to use',
  :type => 'string',
  :default => '/opt/rbenv/shims/ruby'
