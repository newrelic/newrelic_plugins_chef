# verify java dependency
verify_java 'Wikipedia Example Java Plugin'

# check required attributes
verify_attributes do
  attributes [
    'node[:newrelic][:license_key]',
    'node[:newrelic][:wikipedia_example_java][:install_path]',
    'node[:newrelic][:wikipedia_example_java][:user]'
  ]
end

verify_license_key node[:newrelic][:license_key]

install_plugin 'newrelic_wikipedia_example_java_plugin' do
  plugin_version   node[:newrelic][:wikipedia_example_java][:version]
  install_path     node[:newrelic][:wikipedia_example_java][:install_path]
  plugin_path      node[:newrelic][:wikipedia_example_java][:plugin_path]
  download_url     node[:newrelic][:wikipedia_example_java][:download_url]
  user             node[:newrelic][:wikipedia_example_java][:user]
end

# create template newrelic.json file
template "#{node[:newrelic][:wikipedia_example_java][:plugin_path]}/config/newrelic.json" do
  source 'wikipedia_example_java/newrelic.json.erb'
  action :create
  owner node[:newrelic][:wikipedia_example_java][:user]
  mode '0400'
  notifies :restart, "service[newrelic-wikipedia-example-java-plugin]"
end

# create template plugin.json file
template "#{node[:newrelic][:wikipedia_example_java][:plugin_path]}/config/plugin.json" do
  source 'wikipedia_example_java/plugin.json'
  action :create
  owner node[:newrelic][:wikipedia_example_java][:user]
  mode '0400'
  notifies :restart, "service[newrelic-wikipedia-example-java-plugin]"
end

# install init.d script and start service
plugin_service 'newrelic-wikipedia-example-java-plugin' do
  daemon          'plugin.jar'
  daemon_dir      node[:newrelic][:wikipedia_example_java][:plugin_path]
  plugin_name     'Wikipedia Example Java Plugin'
  plugin_version  node[:newrelic][:wikipedia_example_java][:version]
  user            node[:newrelic][:wikipedia_example_java][:user]
  run_command     "java #{node[:newrelic][:wikipedia_example_java][:java_options]} -jar"
end
