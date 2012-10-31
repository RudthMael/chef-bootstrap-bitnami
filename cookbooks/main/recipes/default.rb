package "git-core"

include_recipe "nginx::source"

user node[:user][:name] do
	node[:user][:password]	
	gid "admin"
	home "/home/#{node[:user][:name]}"
	supports manage_home: true
	shell "/bin/bash"
end

template "/home/#{node[:user][:name]}/.bashrc" do
	source "bashrc.erb"
	owner node[:user][:name]
end

directory "/home/#{node[:user][:name]}/production" do
	owner node[:user][:name]
end

file "/home/#{node[:user][:name]}/production/index.html" do
	owner node[:user][:name]
	content "<h1>Hello Brokantt</h1>"
end

file "#{node[:nginx][:dir]}/sites-available/brokantt" do
	content "server { root /home/#{node[:user][:name]}/brokantt; }"
end

nginx_site "brokantt"
