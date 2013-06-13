#
# Cookbook Name:: riemann-client
# Recipe:: fixed
#
# Copyright (C) 2013 cloudbau GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# 

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
    version node[:riemann][:client_version]
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
