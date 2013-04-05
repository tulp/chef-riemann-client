def get_riemann_server_ip
  if node[:riemann][:server][:bind_ip]
    node[:riemann][:server][:bind_ip]
  else
    search(:node, "recipes:riemann-server AND chef_environment:#{node.chef_environment}").map {|n| n[:riemann][:server][:bind_ip]}.first
  end
end
