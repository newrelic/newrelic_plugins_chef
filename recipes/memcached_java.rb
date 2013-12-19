# verify java dependency
verify_java 'Memcached - Java Plugin'

# check required attributes
verify_attributes do
  attributes [
    'node[:newrelic][:license_key]',
    'node[:newrelic][:memcached_java][:install_path]',
    'node[:newrelic][:memcached_java][:user]',
    'node[:newrelic][:memcached_java][:servers]'
  ]
end

verify_license_key node[:newrelic][:license_key]

install_plugin 'newrelic_memcached_java_plugin' do
  plugin_version   node[:newrelic][:memcached_java][:version]
  install_path     node[:newrelic][:memcached_java][:install_path]
  plugin_path      node[:newrelic][:memcached_java][:plugin_path]
  download_url     node[:newrelic][:memcached_java][:download_url]
  user             node[:newrelic][:memcached_java][:user]
end

# create template newrelic.properties file
template "#{node[:newrelic][:memcached_java][:plugin_path]}/config/newrelic.properties" do
  source 'memcached_java/newrelic.properties.erb'
  action :create
  owner node[:newrelic][:memcached_java][:user]
  mode "0400"
  notifies :restart, "service[newrelic-memcached-java-plugin]"
end

# create template memcached.hosts.json file
template "#{node[:newrelic][:memcached_java][:plugin_path]}/config/memcached.hosts.json" do
  source 'memcached_java/memcached.hosts.json.erb'
  action :create
  owner node[:newrelic][:memcached_java][:user]
  mode "0400"
  notifies :restart, "service[newrelic-memcached-java-plugin]"
end

# install init.d script and start service
plugin_service 'newrelic-memcached-java-plugin' do
  daemon          'newrelic_memcached_plugin*.jar'
  daemon_dir      node[:newrelic][:memcached_java][:plugin_path]
  plugin_name     'Memcached - Java'
  plugin_version  node[:newrelic][:memcached_java][:version]
  run_command     "sudo -u #{node[:newrelic][:memcached_java][:user]} java #{node[:newrelic][:memcached_java][:java_options]} -jar"
end
