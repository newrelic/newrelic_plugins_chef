# verify ruby dependency
verify_ruby 'Wikipedia Example Ruby Plugin'

# check required attributes
verify_attributes do
  attributes [
    'node[:newrelic][:license_key]',
    'node[:newrelic][:wikipedia_example_ruby][:install_path]',
    'node[:newrelic][:wikipedia_example_ruby][:user]'
  ]
end

verify_license_key node[:newrelic][:license_key]

install_plugin 'newrelic_wikipedia_example_ruby_plugin' do
  plugin_version   node[:newrelic][:wikipedia_example_ruby][:version]
  install_path     node[:newrelic][:wikipedia_example_ruby][:install_path]
  plugin_path      node[:newrelic][:wikipedia_example_ruby][:plugin_path]
  download_url     node[:newrelic][:wikipedia_example_ruby][:download_url]
  user             node[:newrelic][:wikipedia_example_ruby][:user]
end

# newrelic template
template "#{node[:newrelic][:wikipedia_example_ruby][:plugin_path]}/config/newrelic_plugin.yml" do
  source 'wikipedia_example_ruby/newrelic_plugin.yml.erb'
  action :create
  owner node[:newrelic][:wikipedia_example_ruby][:user]
  notifies :restart, 'service[newrelic-wikipedia-example-ruby-plugin]'
end

# install bundler gem and run 'bundle install'
bundle_install do
  path node[:newrelic][:wikipedia_example_ruby][:plugin_path]
  user node[:newrelic][:wikipedia_example_ruby][:user]
end

# install init.d script and start service
plugin_service 'newrelic-wikipedia-example-ruby-plugin' do
  daemon          './newrelic_wikipedia_agent'
  daemon_dir      node[:newrelic][:wikipedia_example_ruby][:plugin_path]
  plugin_name     'Wikipedia Example Ruby Plugin'
  plugin_version  node[:newrelic][:wikipedia_example_ruby][:version]
  user            node[:newrelic][:wikipedia_example_ruby][:user]
  run_command     'bundle exec'
end
