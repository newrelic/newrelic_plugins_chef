name              'newrelic_plugins'
maintainer        'New Relic, Inc.'
maintainer_email  'support@newrelic.com'
license           'MIT'
description       'Installs New Relic Plugins.'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '1.1.0'

recipe 'newrelic_plugins::aws_cloudwatch', 'Installs New Relic AWS Cloudwatch Plugin'
recipe 'newrelic_plugins::example', 'Installs New Relic Example Plugin'
recipe 'newrelic_plugins::f5', 'Installs New Relic F5 Plugin'
recipe 'newrelic_plugins::mysql', 'Installs New Relic MySQL Plugin'
recipe 'newrelic_plugins::memcached_java', 'Installs New Relic Memcached Java Plugin'
recipe 'newrelic_plugins::memcached_ruby', 'Installs New Relic Memcached Ruby Plugin'
recipe 'newrelic_plugins::rackspace_load_balancers', 'Installs New Relic Rackspace Load Balancers Plugin'
recipe 'newrelic_plugins::wikipedia_example_java', 'Installs New Relic Wikipedia Example Java Plugin'
recipe 'newrelic_plugins::wikipedia_example_ruby', 'Installs New Relic Wikipedia Example Ruby Plugin'

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
    'newrelic_plugins::example',
    'newrelic_plugins::f5',
    'newrelic_plugins::mysql',
    'newrelic_plugins::memcached_java',
    'newrelic_plugins::memcached_ruby',
    'newrelic_plugins::rackspace_load_balancers',
    'newrelic_plugins::wikipedia_example_java',
    'newrelic_plugins::wikipedia_example_ruby'
  ]

attribute 'newrelic/aws_cloudwatch/install_path',
  :display_name => 'New Relic AWS Cloudwatch Plugin Install Path',
  :description => 'Install Path for New Relic AWS Cloudwatch Plugin',
  :type => 'string',
  :required => 'required',
  :default => '/opt/newrelic',
  :recipes => ['newrelic_plugins::aws_cloudwatch']

attribute 'newrelic/aws_cloudwatch/user',
  :display_name => 'New Relic AWS Cloudwatch Plugin User',
  :description => 'User to run as for New Relic AWS Cloudwatch Plugin',
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
  :default => '/opt/newrelic',
  :recipes => ['newrelic_plugins::example']

attribute 'newrelic/example/user',
  :display_name => 'New Relic Example Plugin User',
  :description => 'User to run as for New Relic Example Plugin',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::example']

attribute 'newrelic/f5/install_path',
  :display_name => 'New Relic F5 Plugin Install Directory',
  :description => 'Install Directory for New Relic F5 Plugin',
  :type => 'string',
  :required => 'required',
  :default => '/opt/newrelic',
  :recipes => ['newrelic_plugins::f5']

attribute 'newrelic/f5/user',
  :display_name => 'New Relic F5 Plugin User',
  :description => 'User to run as for New Relic F5 Plugin',
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
  :default => '/opt/newrelic',
  :recipes => ['newrelic_plugins::mysql']

attribute 'newrelic/mysql/user',
  :display_name => 'New Relic MySQL Plugin User',
  :description => 'User to run as for New Relic MySQL Plugin',
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

attribute 'newrelic/memcached_java/install_path',
  :display_name => 'New Relic Memcached Java Plugin Install Path',
  :description => 'Install Path for New Relic Memcached Java Plugin',
  :type => 'string',
  :required => 'required',
  :default => '/opt/newrelic',
  :recipes => ['newrelic_plugins::memcached_java']

attribute 'newrelic/memcached_java/user',
  :display_name => 'New Relic Memcached Java Plugin User',
  :description => 'User to run as for New Relic Memcached Java Plugin',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::memcached_java']

attribute 'newrelic/memcached_java/servers',
  :display_name => 'New Relic Memcached Java Plugin Servers',
  :description => 'Memcached servers for New Relic Memcached Java Plugin',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::memcached_java']

attribute 'newrelic/memcached_java/java_options',
  :display_name => 'New Relic Memcached Java Plugin Java Options',
  :description => 'Java options for New Relic Memcached Java Plugin',
  :type => 'string',
  :required => 'optional',
  :recipes => ['newrelic_plugins::memcached_java']

attribute 'newrelic/memcached_ruby/install_path',
  :display_name => 'New Relic Memcached Ruby Plugin Install Path',
  :description => 'Install Path for New Relic Memcached Ruby Plugin',
  :type => 'string',
  :required => 'required',
  :default => '/opt/newrelic',
  :recipes => ['newrelic_plugins::memcached_ruby']

attribute 'newrelic/memcached_ruby/user',
  :display_name => 'New Relic Memcached Ruby Plugin User',
  :description => 'User to run as for New Relic Memcached Ruby Plugin',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::memcached_ruby']

attribute 'newrelic/memcached_ruby/agents',
  :display_name => 'New Relic Memcached Ruby Plugin Agents',
  :description => 'Agents for New Relic Memcached Ruby Plugin',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::memcached_ruby']

attribute 'newrelic/rackspace_load_balancers/install_path',
  :display_name => 'New Relic Rackspace Load Balancers Plugin Install Path',
  :description => 'Install Path for Rackspace Load Balancers Plugin',
  :type => 'string',
  :required => 'required',
  :default => '/opt/newrelic',
  :recipes => ['newrelic_plugins::rackspace_load_balancers']

attribute 'newrelic/rackspace_load_balancers/user',
  :display_name => 'New Relic Rackspace Load Balancers Plugin User',
  :description => 'User to run as for New Relic Rackspace Load Balancers Plugin',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::rackspace_load_balancers']

attribute 'newrelic/rackspace_load_balancers/username',
  :display_name => 'New Relic Rackspace Load Balancers Plugin Username',
  :description => 'Username for Rackspace Load Balancers',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::rackspace_load_balancers']

attribute 'newrelic/rackspace_load_balancers/api_key',
  :display_name => 'New Relic Rackspace Load Balancers API Key',
  :description => 'API Key for Rackspace Load Balancers',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::rackspace_load_balancers']

attribute 'newrelic/rackspace_load_balancers/region',
  :display_name => 'New Relic Rackspace Load Balancers Region',
  :description => 'Region for Rackspace Load Balancers',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::rackspace_load_balancers']

attribute 'newrelic/wikipedia_example_java/install_path',
  :display_name => 'New Relic Wikipedia Example Java Plugin Install Path',
  :description => 'Install Path for New Relic Wikipedia Example Java Plugin',
  :type => 'string',
  :required => 'required',
  :default => '/opt/newrelic',
  :recipes => ['newrelic_plugins::wikipedia_example_java']

attribute 'newrelic/wikipedia_example_java/user',
  :display_name => 'New Relic Wikipedia Example Java Plugin User',
  :description => 'User to run as for New Relic Wikipedia Example Java Plugin',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::wikipedia_example_java']

attribute 'newrelic/wikipedia_example_ruby/install_path',
  :display_name => 'New Relic Wikipedia Example Ruby Plugin Install Path',
  :description => 'Install Path for New Relic Wikipedia Example Ruby Plugin',
  :type => 'string',
  :required => 'required',
  :default => '/opt/newrelic',
  :recipes => ['newrelic_plugins::wikipedia_example_ruby']

attribute 'newrelic/wikipedia_example_ruby/user',
  :display_name => 'New Relic Wikipedia Example Ruby Plugin User',
  :description => 'User to run as for New Relic Wikipedia Example Ruby Plugin',
  :type => 'string',
  :required => 'required',
  :recipes => ['newrelic_plugins::wikipedia_example_ruby']