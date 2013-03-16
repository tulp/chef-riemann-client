#riemann_server = 
# we currently dont use chef server so we have do define the server-ip ourselve
riemann_server = '192.168.90.100'

unless Chef::Config[:solo]
  runit_service "riemann-health" do
    options :riemann_host => search(:node, "recipe:riemann\\:\\:server AND chef_environment:#{node.chef_environment}").first
    options :name => node.name
  end
else
  runit_service "riemann-health" do
    options :riemann_host =>
    options :name => 
  end
end

service 'riemann-health' do
  supports :restart => true
  action [:start]
end