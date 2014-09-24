# verify ruby dependency
verify_ruby 'Memcached - Ruby Plugin'

# check required attributes
verify_attributes do
  attributes [
    'node[:newrelic][:license_key]', 
    'node[:newrelic][:memcached_ruby][:install_path]',
    'node[:newrelic][:memcached_ruby][:user]'
  ]
end

verify_license_key node[:newrelic][:license_key]

install_plugin 'newrelic_memcached_ruby_plugin' do
  plugin_version   node[:newrelic][:memcached_ruby][:version]
  install_path     node[:newrelic][:memcached_ruby][:install_path]
  plugin_path      node[:newrelic][:memcached_ruby][:plugin_path]
  download_url     node[:newrelic][:memcached_ruby][:download_url] 
  user             node[:newrelic][:memcached_ruby][:user]
end

# newrelic template
template "#{node[:newrelic][:memcached_ruby][:plugin_path]}/config/newrelic_plugin.yml" do
  source 'memcached_ruby/newrelic_plugin.yml.erb'
  action :create
  owner node[:newrelic][:memcached_ruby][:user]
  notifies :restart, 'service[newrelic-memcached-ruby-plugin]'
end

# install bundler gem and run 'bundle install'
bundle_install do
  path node[:newrelic][:memcached_ruby][:plugin_path]
  user node[:newrelic][:memcached_ruby][:user]
end

# install init.d script and start service
plugin_service 'newrelic-memcached-ruby-plugin' do
  daemon          './newrelic_memcached_agent'
  daemon_dir      node[:newrelic][:memcached_ruby][:plugin_path]
  plugin_name     'Memcached - Ruby'
  plugin_version  node[:newrelic][:memcached_ruby][:version]
  user            node[:newrelic][:memcached_ruby][:user]
  run_command     'bundle exec'
end
