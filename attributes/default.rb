#general ruby/chef setup
default[:riemann][:ruby_shebang] = '#!/opt/chef/embedded/bin/ruby'
default[:riemann][:ruby_exec] = "/opt/chef/embedded/bin/ruby"

#general runner
default[:riemann][:riemann_runner_executable] = "/usr/bin/riemann-runner"

#nova-check specific
default[:riemann][:nova][:interval] = 60
default[:riemann][:nova][:riemann_runner_executable] = "/usr/bin/riemann-runner-nova"
default[:riemann][:nova][:riemann_executable] = "/usr/bin/riemann-nova-service"

#fixed-ip check
default[:riemann][:fixed_ip][:threshold] = 2
default[:riemann][:fixed_ip][:interval] = 60
default[:riemann][:fixed_ip][:riemann_runner_executable] = "/usr/bin/riemman-runner-fixed"
default[:riemann][:fixed_ip][:riemann_executable] = "/usr/bin/riemann-fixed-service"