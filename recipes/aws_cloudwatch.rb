# verify ruby dependency
verify_ruby 'AWS Cloudwatch Plugin'

# check required attributes
verify_attributes do
  attributes [
    'node[:newrelic][:license_key]', 
    'node[:newrelic][:aws_cloudwatch][:install_path]', 
    'node[:newrelic][:aws_cloudwatch][:user]',
    'node[:newrelic][:aws_cloudwatch][:aws_access_key]', 
    'node[:newrelic][:aws_cloudwatch][:aws_secret_key]', 
    'node[:newrelic][:aws_cloudwatch][:agents]'
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

install_plugin 'newrelic_aws_cloudwatch_plugin' do
  plugin_version   node[:newrelic][:aws_cloudwatch][:version]
  install_path     node[:newrelic][:aws_cloudwatch][:install_path]
  plugin_path      node[:newrelic][:aws_cloudwatch][:plugin_path]
  download_url     node[:newrelic][:aws_cloudwatch][:download_url]
  user             node[:newrelic][:aws_cloudwatch][:user]
end

# newrelic template
template "#{node[:newrelic][:aws_cloudwatch][:plugin_path]}/config/newrelic_plugin.yml" do
  source 'aws_cloudwatch/newrelic_plugin.yml.erb'
  action :create
  owner node[:newrelic][:aws_cloudwatch][:user]
  notifies :restart, 'service[newrelic-aws-cloudwatch-plugin]'
end

# install bundler gem and run 'bundle install'
bundle_install do
  path node[:newrelic][:aws_cloudwatch][:plugin_path]
  user node[:newrelic][:aws_cloudwatch][:user]
end

# install init.d script and start service
plugin_service 'newrelic-aws-cloudwatch-plugin' do
  daemon          './bin/newrelic_aws'
  daemon_dir      node[:newrelic][:aws_cloudwatch][:plugin_path]
  plugin_name     'AWS Cloudwatch'
  plugin_version  node[:newrelic][:aws_cloudwatch][:version]
  user            node[:newrelic][:aws_cloudwatch][:user]
  run_command     'bundle exec'
end
