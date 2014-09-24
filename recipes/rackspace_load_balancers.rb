# verify ruby dependency
verify_ruby 'Rackspace Load Balancers Plugin'

# check required attributes
verify_attributes do
  attributes [
    'node[:newrelic][:license_key]', 
    'node[:newrelic][:rackspace_load_balancers][:install_path]', 
    'node[:newrelic][:rackspace_load_balancers][:user]',
    'node[:newrelic][:rackspace_load_balancers][:username]',
    'node[:newrelic][:rackspace_load_balancers][:api_key]',
    'node[:newrelic][:rackspace_load_balancers][:region]'
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

install_plugin 'newrelic_rackspace_load_balancers_plugin' do
  plugin_version   node[:newrelic][:rackspace_load_balancers][:version]
  install_path     node[:newrelic][:rackspace_load_balancers][:install_path]
  plugin_path      node[:newrelic][:rackspace_load_balancers][:plugin_path]
  download_url     node[:newrelic][:rackspace_load_balancers][:download_url]
  user             node[:newrelic][:rackspace_load_balancers][:user]
end

# newrelic template
template "#{node[:newrelic][:rackspace_load_balancers][:plugin_path]}/config/newrelic_plugin.yml" do
  source 'rackspace_load_balancers/newrelic_plugin.yml.erb'
  action :create
  owner node[:newrelic][:rackspace_load_balancers][:user]
  notifies :restart, 'service[newrelic-rackspace-load-balancers-plugin]'
end

# install bundler gem and run 'bundle install'
bundle_install do
  path node[:newrelic][:rackspace_load_balancers][:plugin_path]
  user node[:newrelic][:rackspace_load_balancers][:user]
end

# install init.d script and start service
plugin_service 'newrelic-rackspace-load-balancers-plugin' do
  daemon          './bin/newrelic_rs'
  daemon_dir      node[:newrelic][:rackspace_load_balancers][:plugin_path]
  plugin_name     'Rackspace Load Balancers'
  plugin_version  node[:newrelic][:rackspace_load_balancers][:version]
  user            node[:newrelic][:rackspace_load_balancers][:user]
  run_command     'bundle exec'
end
