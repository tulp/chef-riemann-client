include_recipe 'rbenv'

riemann_server = get_riemann_server_ip

# Don't install and start any riemann services when the server is unknown,
# because that would misconfigure them. This happens on the very first
# chef run, when bootstrapping a whole multi-node setup.
if riemann_server
  service 'riemann-fixed' do
    supports :restart => true
  end

  rbenv_gem "riemann-client" do
    ruby_version node[:riemann][:ruby_version]
    version '0.0.8'
    action :install
    notifies :restart, resources(:service => 'riemann-nova')
  end

  rbenv_gem "daemons" do
    ruby_version node[:riemann][:ruby_version]
    version '1.1.9'
    action :install
    notifies :restart, resources(:service => 'riemann-nova')
  end

  template "#{node[:riemann][:fixed_ip][:riemann_runner_executable]}" do
    source "riemann-runner.erb"
    owner "root"
    group "root"
    mode 0755
    variables(
    :executable => "#{node[:riemann][:fixed_ip][:riemann_executable]}",
    :app_name => "fixed_ip")
    action :create
  end

  if Chef::Config[:solo]
    cookbook_file "/usr/bin/nova-manage" do
      source "nova-manage"
      owner "root"
      group "root"
      mode 0777
      backup false
      action :create
    end
  end

  template "/usr/bin/riemann-fixed-service" do
    source "riemann-fixed-check.erb"
    owner "root"
    group "root"
    mode 0755
    variables(:riemann_server_address => riemann_server)
    action :create
  end
  runit_service "riemann-fixed"
end
