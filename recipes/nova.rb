service 'riemann-nova' do
  supports :restart => true
end

gem_package "riemann-client" do
  version '0.0.8'
  action :install
  notifies :restart, resources(:service => 'riemann-nova')
end

gem_package "daemons" do
  version '1.1.9'
  action :install
  notifies :restart, resources(:service => 'riemann-nova')
end

template "#{node[:riemann][:riemann_runner_nova_executable]}" do
  source "riemann-runner.erb"
  owner "root"
  group "root"
  mode 0755
  variables(
  :executable => "#{node[:riemann][:riemann_nova_executable]}")
  action :create
end

unless Chef::Config[:solo]
  puts '###### ---- Using Chef Server Mode for Riemann Nova ---- ######'
  template "/usr/bin/riemann-nova-service" do
    source "riemann-nova-check.erb"
    owner "root"
    group "root"
    mode 0755
    variables(
    :riemann_server_address => search(:node, "recipe:riemann\\:\\:server AND chef_environment:#{node.chef_environment}").first)
    action :create
  end
  runit_service "riemann-nova" do
  end
else
  puts '###### ---- Using Chef Solo Mode for Riemann Nova ---- ######'
  riemann_server = search(:riemann, "id:riemann_server").first
  template "/usr/bin/riemann-nova-service" do
    source "riemann-nova-check.erb"
    owner "root"
    group "root"
    mode 0755
    variables(
    :riemann_server_address => riemann_server['ipaddress'])
    action :create
  end
  runit_service "riemann-nova" do
  end
end