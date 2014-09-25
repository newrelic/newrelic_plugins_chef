# aws cloudwatch plugin attributes
default[:newrelic][:aws_cloudwatch][:version] = "3.3.2"
default[:newrelic][:aws_cloudwatch][:download_url] = "https://github.com/newrelic-platform/newrelic_aws_cloudwatch_plugin/archive/#{node[:newrelic][:aws_cloudwatch][:version]}.tar.gz"
default[:newrelic][:aws_cloudwatch][:install_path] = "/opt/newrelic"
default[:newrelic][:aws_cloudwatch][:plugin_path]  = "#{node[:newrelic][:aws_cloudwatch][:install_path]}/newrelic_aws_cloudwatch_plugin"

# mysql plugin attributes
default[:newrelic][:mysql][:version] = "2.0.0"
default[:newrelic][:mysql][:user] = "root"                #mysql auth info is in a conf file controled by this user
default[:newrelic][:mysql][:download_url] = "https://raw.github.com/newrelic-platform/newrelic_mysql_java_plugin/master/dist/newrelic_mysql_plugin-#{node[:newrelic][:mysql][:version]}.tar.gz"
default[:newrelic][:mysql][:install_path] = "/opt/newrelic"
default[:newrelic][:mysql][:plugin_path] = "#{node[:newrelic][:mysql][:install_path]}/newrelic_mysql_plugin"
default[:newrelic][:mysql][:java_options] = '-Xmx128m'

# memcached (java) plugin attributes
default[:newrelic][:memcached_java][:version] = "2.0.1"
default[:newrelic][:memcached_java][:user] = "root"
default[:newrelic][:memcached_java][:download_url] = "https://raw.github.com/newrelic-platform/newrelic_memcached_java_plugin/master/dist/newrelic_memcached_plugin-#{node[:newrelic][:memcached_java][:version]}.tar.gz"
default[:newrelic][:memcached_java][:install_path] = "/opt/newrelic"
default[:newrelic][:memcached_java][:plugin_path] = "#{node[:newrelic][:memcached_java][:install_path]}/newrelic_memcached_java_plugin"
default[:newrelic][:memcached_java][:java_options] = '-Xmx128m'

# example plugin attributes
default[:newrelic][:example][:version] = "1.0.1"
default[:newrelic][:example][:download_url] = "https://github.com/newrelic-platform/newrelic_example_plugin/archive/release/#{node[:newrelic][:example][:version]}.tar.gz"
default[:newrelic][:example][:install_path] = "/opt/newrelic"
default[:newrelic][:example][:plugin_path] = "#{node[:newrelic][:example][:install_path]}/newrelic_example_plugin"

# f5 plugin attributes
default[:newrelic][:f5][:version] = "1.0.16"
default[:newrelic][:f5][:install_path] = "/opt/newrelic"
default[:newrelic][:f5][:plugin_path] = "#{node[:newrelic][:f5][:install_path]}/newrelic_f5_plugin"

# memcached (ruby) plugin attributes
default[:newrelic][:memcached_ruby][:version] = "1.0.1"
default[:newrelic][:memcached_ruby][:download_url] = "https://github.com/newrelic-platform/newrelic_memcached_plugin/archive/release/#{node[:newrelic][:memcached_ruby][:version]}.tar.gz"
default[:newrelic][:memcached_ruby][:install_path] = "/opt/newrelic"
default[:newrelic][:memcached_ruby][:plugin_path] = "#{node[:newrelic][:memcached_ruby][:install_path]}/newrelic_memcached_ruby_plugin"

# rackspace load balancers attributes
default[:newrelic][:rackspace_load_balancers][:version] = "1.2.0"
default[:newrelic][:rackspace_load_balancers][:download_url] = "https://github.com/newrelic-platform/newrelic_rackspace_load_balancers_plugin/archive/#{node[:newrelic][:rackspace_load_balancers][:version]}.tar.gz"
default[:newrelic][:rackspace_load_balancers][:install_path] = "/opt/newrelic"
default[:newrelic][:rackspace_load_balancers][:plugin_path] = "#{node[:newrelic][:rackspace_load_balancers][:install_path]}/newrelic_rackspace_load_balancers_plugin"

# wikipedia example java plugin attributes
default[:newrelic][:wikipedia_example_java][:version] = "2.0.0"
default[:newrelic][:wikipedia_example_java][:download_url] = "https://github.com/newrelic-platform/newrelic_java_wikipedia_plugin/raw/master/dist/newrelic_wikipedia_plugin-#{node[:newrelic][:wikipedia_example_java][:version]}.tar.gz"
default[:newrelic][:wikipedia_example_java][:install_path] = "/opt/newrelic"
default[:newrelic][:wikipedia_example_java][:plugin_path] = "#{node[:newrelic][:wikipedia_example_java][:install_path]}/newrelic_wikipedia_example_java_plugin"

# wikipedia example ruby plugin attributes
default[:newrelic][:wikipedia_example_ruby][:version] = "1.0.3"
default[:newrelic][:wikipedia_example_ruby][:download_url] = "https://github.com/newrelic-platform/newrelic_wikipedia_plugin/archive/#{node[:newrelic][:wikipedia_example_ruby][:version]}.tar.gz"
default[:newrelic][:wikipedia_example_ruby][:install_path] = "/opt/newrelic"
default[:newrelic][:wikipedia_example_ruby][:plugin_path] = "#{node[:newrelic][:wikipedia_example_ruby][:install_path]}/newrelic_wikipedia_example_ruby_plugin"
