#general ruby/chef setup
default[:riemann][:ruby_shebang] = '#!/opt/chef/embedded/bin/ruby'
default[:riemann][:ruby_exec] = "/opt/chef/embedded/bin/ruby"

#general runner
default[:riemann][:riemann_runner_executable] = "/usr/bin/riemann-runner"

#nova-check specific runner
default[:riemann][:app_name] = "nova-check"
default[:riemann][:riemann_runner_nova_executable] = "/usr/bin/riemann-runner-nova"
default[:riemann][:riemann_nova_executable] = "/usr/bin/riemann-nova-service"