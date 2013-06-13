#
# Cookbook Name:: riemann-client
# Recipe:: default
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
