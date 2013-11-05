# aws cloudwatch plugin attributes
default[:newrelic][:aws_cloudwatch][:version] = "3.1.0"
default[:newrelic][:aws_cloudwatch][:download_url] = "https://github.com/newrelic-platform/newrelic_aws_cloudwatch_plugin/archive/#{node[:newrelic][:aws_cloudwatch][:version]}.tar.gz"
default[:newrelic][:aws_cloudwatch][:plugin_path]  = "#{node[:newrelic][:aws_cloudwatch][:install_path]}/newrelic_aws_cloudwatch_plugin-#{node[:newrelic][:aws_cloudwatch][:version]}"

# mysql plugin attributes
default[:newrelic][:mysql][:version] = "1.0.7"
default[:newrelic][:mysql][:download_url] = "https://raw.github.com/newrelic-platform/newrelic_mysql_java_plugin/master/dist/newrelic_mysql_plugin-#{node[:newrelic][:mysql][:version]}.tar.gz"
default[:newrelic][:mysql][:plugin_path] = "#{node[:newrelic][:mysql][:install_path]}/newrelic_mysql_plugin-#{node[:newrelic][:mysql][:version]}"

# example plugin attributes
default[:newrelic][:example][:version] = "1.0.1"
default[:newrelic][:example][:download_url] = "https://github.com/newrelic-platform/newrelic_example_plugin/archive/release/#{node[:newrelic][:example][:version]}.tar.gz"
default[:newrelic][:example][:plugin_path] = "#{node[:newrelic][:example][:install_path]}/newrelic_example_plugin-release-#{node[:newrelic][:example][:version]}"

# f5 plugin attributes
default[:newrelic][:f5][:version] = "1.0.7"