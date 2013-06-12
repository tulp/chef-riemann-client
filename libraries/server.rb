def get_riemann_server_ip
  if node[:riemann][:server][:bind_ip]
    node[:riemann][:server][:bind_ip]
  elsif node[:riemann][:server][:host] 
    node[:riemann][:server][:host] 
  elsif node[:riemann][:server][:query]
    search(:node, "#{node[:riemann][:server][:query]} AND chef_environment:#{node.chef_environment}").map {|n| n[:riemann][:server][:bind_ip]}.first
  else
    search(:node, "recipes:riemann-server AND chef_environment:#{node.chef_environment}").map {|n| n[:riemann][:server][:bind_ip]}.first
  end
end
