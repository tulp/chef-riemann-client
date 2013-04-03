include_recipe 'rbenv'

riemann_server = get_riemann_server_ip

if riemann_server
  service 'riemann-health' do
    supports :restart => true
  end

  rbenv_gem "riemann-tools" do
    ruby_version node[:riemann][:ruby_version]
    version '0.1.1'
    action :install
    notifies :restart, resources(:service => 'riemann-health')
  end

  runit_service "riemann-health" do
    options ({
      :riemann_host => riemann_server,
      :name => Chef::Config[:solo] ? node[:network][:interfaces][:eth1][:addresses].keys.first : node.name
    }.merge(params))
  end
end
