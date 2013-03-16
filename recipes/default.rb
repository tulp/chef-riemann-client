
gem_package "riemann-client" do
  version '0.0.8'
  action :install
  notifies :restart, resources(:service => 'riemann-health')
end

gem_package "riemann-tools" do
  version '0.1.1'
  action :install
  notifies :restart, resources(:service => 'riemann-health')
end
include_recipe 'riemann-client::health'