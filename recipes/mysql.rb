# verify java dependency
ruby_block "foo" do
  block do
    unless node[:languages][:java] && node[:languages][:java][:version].start_with?('1.6', '1.7')
      Chef::Application.fatal!("The New Relic MySQL Plugin requires a Java version >= 1.6 -" +
        " For more information, see https://docs.newrelic.com/docs/plugins/installing-a-plugin")
    end
  end
end

# check required attributes
ruby_block "bar" do
  block do
    attributes = [
      'node[:newrelic][:license_key]',
      'node[:newrelic][:mysql][:install_path]',
      'node[:newrelic][:mysql][:servers]'
    ]
    missing_attributes = attributes.select { |attribute| eval(attribute).nil? }
    unless missing_attributes.empty?
      Chef::Application.fatal!("You must provide the following attributes: #{missing_attributes.join(', ')}. For more information, see <INSERT_URL_HERE>")
    end

    unless /^[0-9a-fA-F]{40}$/ =~ node['newrelic']['license_key']
      Chef::Application.fatal!("The provided New Relic License Key is invalid: #{node['newrelic']['license_key']}. For more information, see https://docs.newrelic.com/docs/subscriptions/license-key")
    end
  end
end

file_name      = "newrelic_mysql_plugin-#{node['newrelic']['mysql']['version']}"
plugin_path    = "#{node['newrelic']['mysql']['install_path']}/#{file_name}"
download_path  = "#{plugin_path}.tar.gz"

# create install path
directory node['newrelic']['mysql']['install_path'] do
  action :create
end

# download plugin tar file
remote_file download_path do
  source node['newrelic']['mysql']['download_url']
  action :create_if_missing
  not_if { File.directory?(plugin_path) }
end

# extract plugin tar file
bash "extract newrelic_mysql_plugin resource" do
  cwd node['newrelic']['mysql']['install_path']
  code <<-EOH
    tar zxvf #{download_path}
  EOH
  not_if { File.directory?(plugin_path) }
end

# create template newrelic.properties file
template "#{node['newrelic']['mysql']['install_path']}/newrelic_mysql_plugin-#{node['newrelic']['mysql']['version']}/config/newrelic.properties" do
  source 'mysql/newrelic.properties.erb'
  action :create
  notifies :restart, "service[newrelic-mysql-plugin]"
end

# create template mysql.instance.json file
template "#{node['newrelic']['mysql']['install_path']}/newrelic_mysql_plugin-#{node['newrelic']['mysql']['version']}/config/mysql.instance.json" do
  source 'mysql/mysql.instance.json.erb'
  action :create
  notifies :restart, "service[newrelic-mysql-plugin]"
end

# install init.d script and start service
template "/etc/init.d/newrelic-mysql-plugin" do
  source 'service.erb'
  variables({
    :daemon =>       'newrelic_mysql_plugin*.jar',
    :daemon_dir =>   "#{node['newrelic']['mysql']['install_path']}/newrelic_mysql_plugin-#{node['newrelic']['mysql']['version']}",
    :plugin_name =>  'MySQL',
    :run_command =>  "java #{node['newrelic']['mysql']['java_options']} -jar",
    :service_name => 'newrelic-mysql-plugin',
    :version =>      node['newrelic']['mysql']['version']
  })
  action :create
  mode 0755
end

# manage service
service "newrelic-mysql-plugin" do
  action [:enable, :start]
end
