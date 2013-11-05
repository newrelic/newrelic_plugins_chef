# verify ruby dependency
verify_ruby 'Example Plugin'

# check required attributes
verify_attributes do
  attributes [
    'node[:newrelic][:license_key]', 
    'node[:newrelic][:example][:install_path]'
  ]
end

verify_license_key node[:newrelic][:license_key]

install_plugin 'newrelic_example_plugin' do
  plugin_version   node[:newrelic][:example][:version]
  install_path     node[:newrelic][:example][:install_path]
  download_url     node[:newrelic][:example][:download_url] 
end

# newrelic template
template "#{node[:newrelic][:example][:plugin_path]}/config/newrelic_plugin.yml" do
  source 'example/newrelic_plugin.yml.erb'
  action :create
  notifies :restart, 'service[newrelic-example-plugin]'
end

# install bundler gem and run 'bundle install'
bundle_install do
  path node[:newrelic][:example][:plugin_path]
end

# install init.d script and start service
plugin_service 'newrelic-example-plugin' do
  daemon          './newrelic_example_agent'
  daemon_dir      node[:newrelic][:example][:plugin_path]
  plugin_name     'Example'
  plugin_version  node[:newrelic][:example][:version]
  run_command     'bundle exec'
end