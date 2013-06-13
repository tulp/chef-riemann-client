This Cookbook adds the riemann-client (via gem) and installs the selected checks for : 
- Riemann-Health
- Riemann-Nova (nova-manage service list)
- Riemann-Fixed (nova-manage fixed list)
- Riemann-KVMInstances

All checks are daemonized and integrated via runit and/or ruby-daemonize 

Usage
===================
For Chef-Server:
Just deploy recipes for nodes and create at least one riemann-server via cookbook
(the clients find the ip of the server trough the node deployed with riemann-server recipe)

For Chef-Solo:
Adjust the paths to your environment and boot vagrant machines in combination with riemann-server
