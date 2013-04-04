include_recipe 'rbenv'

riemann_server = get_riemann_server_ip

if riemann_server
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

  template "/usr/bin/riemann-nova-service" do
    source "riemann-nova-check.erb"
    owner "root"
    group "root"
    mode 0755
    action :create
  end

  runit_service "riemann-nova" do
    options ({
      :riemann_host => riemann_server,
      :name => Chef::Config[:solo] ? node[:network][:interfaces][:eth1][:addresses].keys.first : node.name
    }.merge(params))
  end
end
