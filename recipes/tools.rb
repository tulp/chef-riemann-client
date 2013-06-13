include_recipe "riemann-client::default"

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
