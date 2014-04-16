#
# Cookbook Name:: riemann-client
# Recipe:: health
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

include_recipe "riemann-client::tools"

riemann_server = get_riemann_server_ip
Chef::Log.debug("riemann_server = #{riemann_server}")

if riemann_server
  service "riemann-health" do
    supports :restart => true
    subscribes :reload, 'rbenv_gem[riemann-tools]', :delayed
  end

  runit_service "riemann-health" do
    options ({
      :riemann_host => riemann_server,
      :name => node[:riemann][:client][:hostname] || node[:hostname]
    }.merge(params))
  end
end
