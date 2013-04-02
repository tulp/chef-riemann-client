include_recipe 'rbenv'

service 'riemann-nova' do
  supports :start => true
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

template "#{node[:riemann][:nova][:riemann_runner_executable]}" do
  source "riemann-runner.erb"
  owner "root"
  group "root"
  mode 0755
  variables(
  :executable => "#{node[:riemann][:nova][:riemann_executable]}",
  :app_name => "nova")
  action :create
end

riemann_server = get_riemann_server_ip

template "/usr/bin/riemann-nova-service" do
  source "riemann-nova-check.erb"
  owner "root"
  group "root"
  mode 0755
  variables(:riemann_server_address => riemann_server)
  action :create
end

runit_service "riemann-nova"
