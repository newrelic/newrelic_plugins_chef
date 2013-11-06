name              'newrelic_plugins'
maintainer        'New Relic, Inc.'
maintainer_email  'support@newrelic.com'
license           'MIT'
description       'Installs New Relic Plugins.'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.0.1'

recipe 'newrelic_plugins::aws_cloudwatch', 'Installs New Relic AWS Cloudwatch Plugin'
recipe 'newrelic_plugins::example', 'Installs New Relic Example Plugin'
recipe 'newrelic_plugins::f5', 'Installs New Relic F5 Plugin'
recipe 'newrelic_plugins::mysql', 'Installs New Relic MySQL Plugin'

%w{ debian ubuntu centos suse fedora redhat }.each do |os|
  supports os
end

attribute 'newrelic/license_key',
  :display_name => 'New Relic License Key',
  :description => 'License Key for your New Relic account',
  :type => 'string',
  :required => 'required',
  :recipes => [
    'newrelic_plugins::aws_cloudwatch',
    'newrelic_plugins::f5',
    'newrelic_plugins::example',
    'newrelic_plugins::mysql'
  ]

attribute 'newrelic/aws_cloudwatch/install_path',
  :display_name => 'New Relic AWS Cloudwatch Plugin Install Path',
  :description => 'Install Path for New Relic AWS Cloudwatch Plugin',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::aws_cloudwatch']

attribute 'newrelic/aws_cloudwatch/aws_access_key',
  :display_name => 'New Relic AWS Cloudwatch Plugin Access Key',
  :description => 'AWS Access Key for New Relic AWS Cloudwatch Plugin',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::aws_cloudwatch']

attribute 'newrelic/aws_cloudwatch/aws_secret_key',
  :display_name => 'New Relic AWS Cloudwatch Plugin Secret Key',
  :description => 'AWS Secret Key for New Relic AWS Cloudwatch Plugin',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::aws_cloudwatch']

attribute 'newrelic/aws_cloudwatch/agents',
  :display_name => 'New Relic AWS Cloudwatch Plugin Agents',
  :description => 'AWS Agents for New Relic AWS Cloudwatch Plugin',
  :type => 'array',
  :required => 'required',
  :recipes => ['newrelic_plugins::aws_cloudwatch']

attribute 'newrelic/aws_cloudwatch/regions',
  :display_name => 'New Relic AWS Cloudwatch Plugin Regions',
  :description => 'AWS Regions for New Relic AWS Cloudwatch Plugin',
  :type => 'array',
  :required => 'optional',
  :recipes => ['newrelic_plugins::aws_cloudwatch']

attribute 'newrelic/example/install_path',
  :display_name => 'New Relic Example Plugin Install Directory',
  :description => 'Install Directory for New Relic Example Plugin',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::example']

attribute 'newrelic/f5/install_path',
  :display_name => 'New Relic F5 Plugin Install Directory',
  :description => 'Install Directory for New Relic F5 Plugin',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::f5']

attribute 'newrelic/f5/agents',
  :display_name => 'New Relic F5 Plugin Agents',
  :description => 'F5 Agents for New Relic F5 Plugin',
  :type => 'array',
  :required => 'required',
  :recipes => ['newrelic_plugins::f5']

attribute 'newrelic/mysql/install_path',
  :display_name => 'New Relic MySQL Plugin Install Path',
  :description => 'Install Path for New Relic MySQL Plugin',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::mysql']

attribute 'newrelic/mysql_plugin/servers',
  :display_name => 'New Relic MySQL Plugin Server Configurations',
  :description => 'Server Configurations for New Relic MySQL Plugin',
  :type => 'array',
  :required => 'required',
  :recipes => ['newrelic_plugins::mysql']

attribute 'newrelic/mysql_plugin/java_options',
  :display_name => 'New Relic MySQL Plugin Java Command Options',
  :description => 'Java command options for New Relic MySQL Plugin',
  :type => 'string',
  :required => 'optional',
  :recipes => ['newrelic_plugins::mysql']