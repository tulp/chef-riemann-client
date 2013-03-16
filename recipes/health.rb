#riemann_server = 
# we currently dont use chef server so we have do define the server-ip ourselve

service 'riemann-health' do
  supports :restart => true
end

gem_package "riemann-tools" do
  version '0.1.1'
  action :install
  notifies :restart, resources(:service => 'riemann-health')
end

unless Chef::Config[:solo]
  puts '###### ---- Using Chef Server Mode for Riemann ---- ######'
  runit_service "riemann-health" do
    options ({
    :riemann_host => search(:node, "recipe:riemann\\:\\:server AND chef_environment:#{node.chef_environment}").first,
    :name => node.name}.merge(params))
  end
else
  puts '###### ---- Using Chef Solo Mode for Riemann ---- ######'
  runit_service "riemann-health" do
    riemann_server = search(:riemann, "id:riemann_server").first
    options ({
      :riemann_host => riemann_server['ipaddress'],
      :name => node[:network][:interfaces][:eth1][:addresses].keys.first}.merge(params))
  end
end


