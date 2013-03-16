gem_package "riemann-client" do
  version '0.0.8'
  action :install
end

include_recipe 'riemann-client::health'
