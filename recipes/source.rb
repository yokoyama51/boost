include_recipe 'build-essential'

node['boost']['source_install_deps'].each do |pkg|
  package pkg
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node['boost']['file']}" do
  source node['boost']['source'] + node['boost']['file']
  mode '0644'
  action :create_if_missing
end

execute 'install-boost' do # ~FC009
  user 'root'
  cwd Chef::Config[:file_cache_path]
  live_stream true if Chef::Resource::Execute.method_defined?(:live_stream)
  command <<-EOH
  tar xzf #{node['boost']['file']}
  cd #{node['boost']['build_dir']}
  #{node['boost']['build_cmd']}
  echo dummy
  EOH
  not_if '[ -d /usr/local/share/boost/ ] && ( /sbin/ldconfig -v | grep boost )'
end

execute 'ldconfig' do
  user 'root'
  command '/sbin/ldconfig'
  action :nothing
end

cookbook_file '/etc/ld.so.conf.d/boost.conf' do
  owner 'root'
  group 'root'
  mode '0644'
  source 'boost.conf'
  backup false
  notifies :run, 'execute[ldconfig]', :immediately
end
