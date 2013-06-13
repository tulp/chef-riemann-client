#
# Cookbook Name:: riemann-client
# Recipe:: nova
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

if riemann_server
  service 'riemann-nova' do
    supports :start => true
    supports :restart => true
  end

  rbenv_gem "riemann-tools" do
    ruby_version node[:riemann][:ruby_version]
    version '0.1.1'
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
