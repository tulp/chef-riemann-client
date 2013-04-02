include_recipe 'rbenv'

service 'riemann-kvminstances' do
  supports :restart => true
  supports :start => true
end

rbenv_gem "riemann-tools" do
  ruby_version node[:riemann][:ruby_version]
  version '0.1.1'
  action :install
  notifies :restart, resources(:service => 'riemann-kvminstances')
end

riemann_server = get_riemann_server_ip

runit_service "riemann-kvminstances" do
  options({
    :riemann_host => riemann_server,
    :name => Chef::Config[:solo] ? node[:network][:interfaces][:eth1][:addresses].keys.first : node.name
  }.merge(params))
end
