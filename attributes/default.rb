#general ruby/chef setup
default[:riemann][:ruby_shebang] = '#!/opt/rbenv/shims/ruby'
default[:riemann][:ruby_exec] = "/opt/rbenv/shims/ruby"
default[:riemann][:ruby_version] = "1.9.3-p286"

#general runner
default[:riemann][:riemann_runner_executable] = "/usr/bin/riemann-runner"

#nova-check specific
default[:riemann][:nova][:interval] = 30
default[:riemann][:nova][:riemann_runner_executable] = "/usr/bin/riemann-runner-nova"
default[:riemann][:nova][:riemann_executable] = "/usr/bin/riemann-nova-service"

#fixed-ip check
default[:riemann][:fixed_ip][:threshold] = 2
default[:riemann][:fixed_ip][:interval] = 60
default[:riemann][:fixed_ip][:riemann_runner_executable] = "/usr/bin/riemann-runner-fixed"
default[:riemann][:fixed_ip][:riemann_executable] = "/usr/bin/riemann-fixed-service"

default[:riemann][:server][:bind_ip] = nil
