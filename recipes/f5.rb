# verify ruby dependency
verify_ruby 'F5 Plugin'

# check required attributes
verify_attributes do
  attributes [
    'node[:newrelic][:license_key]', 
    'node[:newrelic][:f5][:agents]',
    'node[:newrelic][:f5][:install_path]'
  ]
end

verify_license_key node[:newrelic][:license_key]

# install f5 plugin gem
gem_package 'newrelic_f5_plugin' do
  version node[:newrelic][:f5][:version]
end

# create install path
directory node[:newrelic][:f5][:install_path] do
  action :create
end

directory "#{node[:newrelic][:f5][:install_path]}/config" do
  action :create
end

# newrelic template
template "#{node[:newrelic][:f5][:install_path]}/config/newrelic_plugin.yml" do
  source 'f5/newrelic_plugin.yml.erb'
  action :create
  notifies :restart, 'service[newrelic-f5-plugin]'
end

# install init.d script and start service
plugin_service 'newrelic-f5-plugin' do
  daemon_dir      node[:newrelic][:f5][:install_path]
  plugin_name     'F5'
  plugin_version  node[:newrelic][:f5][:version]
  run_command     'f5_monitor run'
end