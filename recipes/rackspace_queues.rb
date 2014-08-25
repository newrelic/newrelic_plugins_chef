# verify ruby dependency
verify_ruby 'Rackspace Queues Plugin'

# check required attributes
verify_attributes do
  attributes [
    'node[:newrelic][:license_key]', 
    'node[:newrelic][:rackspace_queues][:install_path]', 
    'node[:newrelic][:rackspace_queues][:user]',
    'node[:newrelic][:rackspace_queues][:username]',
    'node[:newrelic][:rackspace_queues][:api_key]',
    'node[:newrelic][:rackspace_queues][:region]'
  ]
end

verify_license_key node[:newrelic][:license_key]

# nokogiri dependencies - debian vs rhel
if platform_family?('debian')
  package 'libxml2-dev'
  package 'libxslt-dev'
else
  package 'libxml2'
  package 'libxml2-devel'
  package 'libxslt'
  package 'libxslt-devel'
end

install_plugin 'newrelic_rackspace_queues_plugin' do
  plugin_version   node[:newrelic][:rackspace_queues][:version]
  install_path     node[:newrelic][:rackspace_queues][:install_path]
  plugin_path      node[:newrelic][:rackspace_queues][:plugin_path]
  download_url     node[:newrelic][:rackspace_queues][:download_url]
  user             node[:newrelic][:rackspace_queues][:user]
end

# newrelic template
template "#{node[:newrelic][:rackspace_queues][:plugin_path]}/config/newrelic_plugin.yml" do
  source 'rackspace_queues/newrelic_plugin.yml.erb'
  action :create
  owner node[:newrelic][:rackspace_queues][:user]
  notifies :restart, 'service[newrelic-rackspace-queues-plugin]'
end

# install bundler gem and run 'bundle install'
bundle_install do
  path node[:newrelic][:rackspace_queues][:plugin_path]
  user node[:newrelic][:rackspace_queues][:user]
end

# install init.d script and start service
plugin_service 'newrelic-rackspace-queues-plugin' do
  daemon          './bin/newrelic_rs'
  daemon_dir      node[:newrelic][:rackspace_queues][:plugin_path]
  plugin_name     'Rackspace Queues'
  plugin_version  node[:newrelic][:rackspace_queues][:version]
  run_command     "sudo -u #{node[:newrelic][:rackspace_queues][:user]} bundle exec"
end