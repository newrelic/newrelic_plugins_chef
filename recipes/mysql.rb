# verify java dependency
verify_java 'MySQL Plugin'

# check required attributes
verify_attributes do
  attributes [
    'node[:newrelic][:license_key]',
    'node[:newrelic][:mysql][:install_path]',
    'node[:newrelic][:mysql][:user]',
    'node[:newrelic][:mysql][:servers]'
  ]
end

verify_license_key node[:newrelic][:license_key]

install_plugin 'newrelic_mysql_plugin' do
  plugin_version   node[:newrelic][:mysql][:version]
  install_path     node[:newrelic][:mysql][:install_path]
  plugin_path      node[:newrelic][:mysql][:plugin_path]
  download_url     node[:newrelic][:mysql][:download_url]
  user             node[:newrelic][:mysql][:user]
end

# create template newrelic.properties file
template "#{node[:newrelic][:mysql][:plugin_path]}/config/newrelic.properties" do
  source 'mysql/newrelic.properties.erb'
  action :create
  owner node[:newrelic][:mysql][:user]
  mode "0400"
  notifies :restart, "service[newrelic-mysql-plugin]"
end

# create template mysql.instance.json file
template "#{node[:newrelic][:mysql][:plugin_path]}/config/mysql.instance.json" do
  source 'mysql/mysql.instance.json.erb'
  action :create
  owner node[:newrelic][:mysql][:user]
  mode "0400"
  notifies :restart, "service[newrelic-mysql-plugin]"
end

# install init.d script and start service
plugin_service 'newrelic-mysql-plugin' do
  daemon          'newrelic_mysql_plugin*.jar'
  daemon_dir      node[:newrelic][:mysql][:plugin_path]
  plugin_name     'MySQL'
  plugin_version  node[:newrelic][:mysql][:version]
  run_command     "sudo -u #{node[:newrelic][:mysql][:user]} java #{node[:newrelic][:mysql][:java_options]} -jar"
end
