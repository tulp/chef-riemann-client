include_recipe "riemann-client::default"

riemann_server = get_riemann_server_ip

#if riemann_server then

%w{
  libxml2-devel
  libxslt-devel
}.each { |pkg| package pkg }

rbenv_gem "riemann-tools" do
  ruby_version node[:riemann][:ruby_version]
  version node[:riemann][:tools_version]
  action :install
  notifies :run, 'bash[rbenv rehash]'
end

bash('rbenv rehash'){ action :nothing }

node[:riemann][:use_tools].each do |tool|
  service "riemann-#{tool}" do
    supports :restart => true
    subscribes :reload, 'rbenv_gem[riemann-tools]', :delayed
  end

  runit_service "riemann-#{tool}" do
    options ({
      :riemann_host => riemann_server,
      :name => Chef::Config[:solo] ? node[:network][:interfaces][:eth1][:addresses].keys.first : node[:name]
    }.merge(params))
  end
end

#end
