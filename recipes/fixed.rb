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
    action :create
  end
  
  runit_service "riemann-fixed" do
    options ({
      :riemann_host => riemann_server,
      :name => Chef::Config[:solo] ? node[:network][:interfaces][:eth1][:addresses].keys.first : node.name
    }.merge(params))
  end
end
