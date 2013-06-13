include_recipe "riemann-client::tools"

riemann_server = get_riemann_server_ip

if riemann_server

  service "riemann-net" do
    supports :restart => true
    subscribes :reload, 'rbenv_gem[riemann-tools]', :delayed
  end

  runit_service "riemann-net" do
    options ({
      :riemann_host => riemann_server,
      :name => Chef::Config[:solo] ? node[:network][:interfaces][:eth1][:addresses].keys.first : node[:name]
    }.merge(params))
  end

end
