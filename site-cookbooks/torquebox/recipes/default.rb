#
# Cookbook Name:: torquebox
# Recipe:: default
#
# Copyright 2013, Erwan Arzur
#
# This file is licensed under the WTFPL (http://www.wtfpl.net)
#

package "unzip"

install_path = node['torquebox']['install_path']
jboss_home = "#{install_path}/jboss"
jruby_home = "#{install_path}/jruby"
torquebox_dist_path = "#{node['torquebox']['dist_home']}/torquebox-#{node['torquebox']['version']}"

user node['torquebox']['user'] do
  home install_path
  system true
  gid node['torquebox']['group']
end

group node['torquebox']['group'] do
  action [:create,:manage]
  members ['vagrant',node['torquebox']['user']]
end

remote_file "#{Chef::Config['file_cache_path']}/torquebox.zip" do
  source node['torquebox']['source_url']
  owner "root"
  group "root"
  mode "0644"
  checksum "#{node['torquebox']['checksums']}"
  notifies :run, "execute[unzip torquebox]",:immediately
  not_if { File.exists? torquebox_dist_path}
end

execute "unzip torquebox" do
  command "unzip -q #{Chef::Config['file_cache_path']}/torquebox.zip"
  cwd node['torquebox']['dist_home']
  user "root"
  # notifies :create,"directory[#{torquebox_dist_path}]",:immediately
  # not_if { File.exists? torquebox_dist_path }
  notifies :run,"execute[chown_dist_path]",:immediately
  notifies :create,"link[#{node['torquebox']['install_path']}]",:immediately
  creates torquebox_dist_path
end

execute "chown_dist_path" do
  command "chown -Rv #{node['torquebox']['user']}:#{node['torquebox']['group']} #{node['torquebox']['install_path']}"
end

link node['torquebox']['install_path'] do
  to torquebox_dist_path
end

template "/etc/profile.d/torquebox.sh" do
  owner "root"
  group "root"
  mode "0644"
  source "torquebox_profile.erb"
end

link "torquebox startup script" do
  target_file "/etc/init.d/torquebox.sh"
  to "#{jboss_home}/bin/init.d/jboss-as-standalone.sh"
end

directory File.dirname(node['torquebox']['pid_file']) do
  owner node['torquebox']['user']
  group node['torquebox']['group']
  mode 0755
end

directory File.dirname(node['torquebox']['log_file']) do
  owner node['torquebox']['user']
  group node['torquebox']['group']
  mode 0755
end

directory "/etc/jboss-as" do
  owner "root"
  group "root"
  mode 0755
end

template "/etc/jboss-as/jboss-as.conf" do
  owner "root"
  group "root"
  mode 0644
  source "jboss-as.conf.erb"
end

service "torquebox" do
  action [:enable,:start]
end