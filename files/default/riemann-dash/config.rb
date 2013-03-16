set :port, 4567
#riemann_server = search(:node, "recipe:riemann\\:\\:server AND chef_environment:#{node.chef_environment}").first
# we currently dont use chef server so we have do define the server-ip ourselve
#config[:client][:host] = '192.168.88.215'
#config[:age_scale] = 3600
#config[:controllers] << '/opt/riemann-dash/controllers'
#config[:views] = '/opt/riemann-dash/views'
#public_dir '/opt/riemann-dash/public'
