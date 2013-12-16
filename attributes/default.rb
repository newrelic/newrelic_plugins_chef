# aws cloudwatch plugin attributes
default[:newrelic][:aws_cloudwatch][:version] = "3.2.0"
default[:newrelic][:aws_cloudwatch][:download_url] = "https://github.com/newrelic-platform/newrelic_aws_cloudwatch_plugin/archive/#{node[:newrelic][:aws_cloudwatch][:version]}.tar.gz"
default[:newrelic][:aws_cloudwatch][:install_path] = "/opt/newrelic"
default[:newrelic][:aws_cloudwatch][:plugin_path]  = "#{node[:newrelic][:aws_cloudwatch][:install_path]}/newrelic_aws_cloudwatch_plugin"

# mysql plugin attributes
default[:newrelic][:mysql][:version] = "1.1.0"
default[:newrelic][:mysql][:user] = "root"                #mysql auth info is in a conf file controled by this user
default[:newrelic][:mysql][:download_url] = "https://raw.github.com/newrelic-platform/newrelic_mysql_java_plugin/master/dist/newrelic_mysql_plugin-#{node[:newrelic][:mysql][:version]}.tar.gz"
default[:newrelic][:mysql][:install_path] = "/opt/newrelic"
default[:newrelic][:mysql][:plugin_path] = "#{node[:newrelic][:mysql][:install_path]}/newrelic_mysql_plugin"
default[:newrelic][:mysql][:java_options] = '-Xmx128m'

# example plugin attributes
default[:newrelic][:example][:version] = "1.0.1"
default[:newrelic][:example][:download_url] = "https://github.com/newrelic-platform/newrelic_example_plugin/archive/release/#{node[:newrelic][:example][:version]}.tar.gz"
default[:newrelic][:example][:install_path] = "/opt/newrelic"
default[:newrelic][:example][:plugin_path] = "#{node[:newrelic][:example][:install_path]}/newrelic_example_plugin"

# f5 plugin attributes
default[:newrelic][:f5][:version] = "1.0.7"
default[:newrelic][:f5][:install_path] = "/opt/newrelic"
default[:newrelic][:f5][:plugin_path] = "#{node[:newrelic][:f5][:install_path]}/newrelic_f5_plugin"
