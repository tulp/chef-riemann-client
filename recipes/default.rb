include_recipe 'runit'
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby node[:riemann][:ruby_version]

user "riemann" do
  home "/home/riemann"
  shell "/bin/bash"
  system true
end

directory "/home/riemann" do
  user "riemann"
end

rbenv_gem "riemann-client" do
  ruby_version node[:riemann][:ruby_version]
  version node[:riemann][:client_version]
  action :install
end

include_recipe 'riemann-client::health'
