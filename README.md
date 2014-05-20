## New Relic Plugin's Cookbook ##

## Overview ##

This cookbook installs, configures and manages as a service New Relic Plugins on Debian/RHEL.

To use the cookbook, add it to your Chef cookbooks path under the name `newrelic_plugins`.

Recipes for the following plugins are provided:

 - [AWS Cloudwatch](#aws-cloudwatch-plugin)
 - [Example (Ruby)](#example-plugin)
 - [F5](#f-plugin)
 - [Memcached - Java](#memcached-java)
 - [Memcached - Ruby](#memcached-ruby)
 - [MySQL](#mysql-plugin)
 - [Rackspace Load Balancers](#rackspace-load-balancers-plugin)
 - [Wikipedia Example Java](#wikipedia-example-java-plugin)
 - [Wikipedia Example Ruby](#wikipedia-example-ruby-plugin)

## Requirements ##

Chef 0.10.10+ and Ohai 6.10+ for `platform_family` support.

The AWS Cloudwatch, Example, F5, Memcached (Ruby), Rackspace Load Balancers, and Wikipedia Example (Ruby) plugins require:

- Ruby >= 1.8.7 
- Rubygems >= 1.8

The MySQL, Memcached (Java) and Wikipedia Example (Java) plugins require: 

- Java Runtime Environment (JRE) >= 1.6

There are several Java and Ruby Chef Cookbooks available on the Chef Community site.

- http://community.opscode.com/cookbooks/java
- http://community.opscode.com/cookbooks/ruby_build

## Platforms ##
 - Debian 
 - Ubuntu 
 - CentOS
 - Red Hat
 - Fedora
 - Amazon
 - FreeBSD

## Usage ##

An example of using the AWS Cloudwatch and MySQL plugins with a defined role. See the below sections for plugin specifics.

    name "newrelic_plugins"
    description "System that run New Relic plugins"
    run_list(
      "recipe[newrelic_plugins::aws_cloudwatch]",
      "recipe[newrelic_plugins::mysql]"
    )
    default_attributes(
      "newrelic" => {
        "license_key" => "NEW_RELIC_LICENSE_KEY",
        "aws_cloudwatch" => {
          "install_path" => "/path/to/plugin",
          "user" => "newrelic",
          "aws_access_key" => "AWS_ACCESS_KEY",
          "aws_secret_key" => "AWS_SECRET_KEY",
          "agents" => [
            "ec2",
            "ebs",
            "elb"
          ]
        },
        "mysql" => {
          "install_path" => "/path/to/plugin",
          "user" => "newrelic",
          "servers" => [
            {
              "name"          => "Production 1",
              "host"          => "localhost",
              "metrics"       => "status,newrelic",
              "mysql_user"    => "USER",
              "mysql_passwd"  => "CLEAR_TEXT_PASSWORD"
            }
          ]
        }
      }
    )

## AWS Cloudwatch Plugin ##

#### Attributes: ####
 
 `node[:newrelic][:license_key]` - _(required)_ New Relic License Key
 
 `node[:newrelic][:aws_cloudwatch][:install_path]` -  _(required)_ Install directory. Defaults to `/opt/newrelic`. Any downloaded files will be placed here. The plugin will be installed within this directory at `newrelic_aws_cloudwatch_plugin`. 
 
 `node[:newrelic][:aws_cloudwatch][:user]` - _(required)_ User to run as
 
 `node[:newrelic][:aws_cloudwatch][:aws_access_key]` -  _(required)_ AWS Cloudwatch Access Key
 
 `node[:newrelic][:aws_cloudwatch][:aws_secret_key]` -  _(required)_ AWS Cloudwatch Secret Key
 
 `node[:newrelic][:aws_cloudwatch][:agents]` -  _(required)_ Array of AWS Cloudwatch agents. Valid values are `ec`, `ec2`, `ebs`, `elb`, `rds`, `sqs`, and `sns`
 
 `node[:newrelic][:aws_cloudwatch][:regions]` - _(optional)_ Array of AWS Cloudwatch regions. e.g. `us-east-1`. Defaults to all available regions.

#### Usage: ####

    name "newrelic_aws_cloudwatch_plugin"
    description "System that monitors AWS Cloudwatch"
    run_list(
      "recipe[newrelic_plugins::aws_cloudwatch]"
    )
    default_attributes(
      "newrelic" => {
        "license_key" => "NEW_RELIC_LICENSE_KEY",
        "aws_cloudwatch" => {
          "install_path" => "/path/to/plugin",
          "user" => "newrelic",
          "aws_access_key" => "AWS_ACCESS_KEY",
          "aws_secret_key" => "AWS_SECRET_KEY",
          "agents" => [
            "ec2",
            "ebs",
            "elb"
          ]
        }
      }
    )

For additional info, see https://github.com/newrelic-platform/newrelic_aws_cloudwatch_plugin

## Example Plugin ##

#### Attributes: ####

 `node[:newrelic][:license_key]` - _(required)_ New Relic License Key
 
 `node[:newrelic][:example][:install_path]` -  _(required)_ Install directory. Defaults to `/opt/newrelic`. Any downloaded files will be placed here. The plugin will be installed within this directory at `newrelic_example_plugin`.
 
 `node[:newrelic][:example][:user]` - _(required)_ User to run as
 
#### Usage: ####

    name "newrelic_example_plugin"
    description "System that runs the Example Plugin"
    run_list(
      "recipe[newrelic_plugins::example]"
    )
    default_attributes(
      "newrelic" => {
        "license_key" => "NEW_RELIC_LICENSE_KEY",
        "example" => {
          "install_path" => "/path/to/plugin",
          "user" => "newrelic"
        }
      }
    )

For additional info, see https://github.com/newrelic-platform/newrelic_example_plugin

## F5 Plugin ##

#### Attributes: ####

 `node[:newrelic][:license_key]` - _(required)_ New Relic License Key
 
 `node[:newrelic][:f5][:install_path]` -  _(required)_ Install directory. Defaults to `/opt/newrelic`. The plugin will be installed within this directory at `newrelic_f5_plugin`.
 
 `node[:newrelic][:f5][:user]` - _(required)_ User to run as
 
 `node[:newrelic][:f5][:agents]` - _(required)_ Array of F5 agents to monitor.

#### Usage: ####

    name "newrelic_f5_plugin"
    description "System that monitors F5"
    run_list(
      "recipe[newrelic_plugins::f5]"
    )
    default_attributes(
      "newrelic" => {
        "license_key" => "NEW_RELIC_LICENSE_KEY",
        "f5" => {
          "install_path" => "/path/to/plugin",
          "user" => "newrelic",
          "agents" => [
            {
              "name"           => "f5",
              "hostname"       => "localhost",
              "port"           => 651
              "snmp_community" => "community"
            }
          ]
        }
      }
    )

For additional info, see https://github.com/newrelic-platform/newrelic_f5_plugin

## Memcached (Java) ##

#### Attributes: ####
 
 `node[:newrelic][:license_key]` - _(required)_ New Relic License Key
 
 `node[:newrelic][:memcached_java][:install_path]` -  _(required)_ Install directory. Defaults to `/opt/newrelic`. Any downloaded files will be placed here. The plugin will be installed within this directory at `newrelic_memcached_java_plugin`.
 
 `node[:newrelic][:memcached_java][:user]` - _(required)_ User to run as.
 
 `node[:newrelic][:memcached_java][:servers]` -  _(required)_ Array of Memcached Servers. If using the default port, the `port` attribute can be left off.

 `node[:newrelic][:memcached_java][:java_options]` -  _(optional)_ String of java options that will be passed to the init script java command. E.g. `-Dhttps.proxyHost=proxy.example.com -Dhttps.proxyPort=12345` for proxy support. Defaults to `-Xmx128m` for max 128mb heap size, but can be overridden.
 
#### Usage: ####

    name "newrelic_memcached_java_plugin"
    description "System that monitors Memcached Servers"
    run_list(
      "recipe[newrelic_plugins::memcached_java]"
    )
    default_attributes(
      "newrelic" => {
        "license_key" => "NEW_RELIC_LICENSE_KEY",
        "memcached_java" => {
          "install_path" => "/path/to/plugin",
          "user" => "newrelic",
          "java_options" => "-Dhttps.proxyHost=proxy.example.com -Dhttps.proxyPort=12345",
          "servers" => [
            {
              "name" => "Host - 1",
              "host" => "host.example.com",
              "port" => 11211
            },
            {
              "name" => "Host - 2",
              "host" => "host2.example.com"        
            }
          ]
        }
      }
    )

For additional info, see https://github.com/newrelic-platform/newrelic_memcached_java_plugin

## Memcached (Ruby) ##

`node[:newrelic][:license_key]` - _(required)_ New Relic License Key
 
 `node[:newrelic][:memcached_ruby][:install_path]` -  _(required)_ Install directory. Defaults to `/opt/newrelic`. The plugin will be installed within this directory at `newrelic_memcached_ruby_plugin`.
 
 `node[:newrelic][:memcached_ruby][:user]` - _(required)_ User to run as.
 
 `node[:newrelic][:memcached_ruby][:agents]` - _(required)_ Array of Memcached hosts to monitor.
 
#### Usage: ####

    name "newrelic_memcached_ruby_plugin"
    description "System that monitors Memcached"
    run_list(
      "recipe[newrelic_plugins::memcached_ruby]"
    )
    default_attributes(
      "newrelic" => {
        "license_key" => "NEW_RELIC_LICENSE_KEY",
        "memcached_ruby" => {
          "install_path" => "/path/to/plugin",
          "user" => "newrelic",
          "agents" => [
            {
              "name"      => "Host - 1",
              "endpoint"  => "localhost",
              "port"      => 11211
            }
          ]
        }
      }
    )

For additional info, see https://github.com/newrelic-platform/newrelic_memcached_plugin

## MySQL Plugin ##

#### Attributes: ####
 
 `node[:newrelic][:license_key]` - _(required)_ New Relic License Key
 
 `node[:newrelic][:msyql][:install_path]` -  _(required)_ Install directory. Defaults to `/opt/newrelic`. Any downloaded files will be placed here. The plugin will be installed within this directory at `newrelic_mysql_plugin`.
 
 `node[:newrelic][:mysql][:user]` - _(required)_ User to run as. Defaults to `root`.
 
 `node[:newrelic][:mysql][:servers]` -  _(required)_ Array of MySQL Servers. If using the default username and password, the `user` and `passwd` attributes can be left off.

 `node[:newrelic][:mysql][:java_options]` -  _(optional)_ String of java options that will be passed to the init script java command. E.g. `-Dhttps.proxyHost=proxy.example.com -Dhttps.proxyPort=12345` for proxy support. Defaults to `-Xmx128m` for max 128mb heap size, but can be overridden.

#### Usage: ####

    name "newrelic_mysql_plugin"
    description "System that monitors MySQL Servers"
    run_list(
      "recipe[newrelic_plugins::mysql]"
    )
    default_attributes(
      "newrelic" => {
        "license_key" => "NEW_RELIC_LICENSE_KEY",
        "mysql" => {
          "install_path" => "/path/to/plugin",
          "user" => "newrelic",
          "java_options" => "-Dhttps.proxyHost=proxy.example.com -Dhttps.proxyPort=12345",
          "servers" => [
            {
              "name"          => "Production Master",
              "host"          => "master-host",
              "metrics"       => "status,newrelic,master",
              "mysql_user"    => "USER_NAME_HERE",
              "mysql_passwd"  => "USER_CLEAR_TEXT_PASSWORD_HERE"
            },
            {
              "name"          => "Production Slave",
              "host"          => "slave-host",
              "metrics"       => "status,newrelic,slave",
              "mysql_user"    => "USER_NAME_HERE",
              "mysql_passwd"  => "USER_CLEAR_TEXT_PASSWORD_HERE"
            }
          ]
        }
      }
    )

For additional info, see https://github.com/newrelic-platform/newrelic_mysql_java_plugin

## Rackspace Load Balancers ##

`node[:newrelic][:license_key]` - _(required)_ New Relic License Key
 
`node[:newrelic][:rackspace_load_balancers][:install_path]` -  _(required)_ Install directory. Defaults to `/opt/newrelic`. The plugin will be installed within this directory at `newrelic_rackspace_load_balancers_plugin`.
 
`node[:newrelic][:rackspace_load_balancers][:user]` - _(required)_ User to run as.
 
`node[:newrelic][:rackspace_load_balancers][:username]` - _(required)_ Username for Rackspace Load Balancers
 
`node[:newrelic][:rackspace_load_balancers][:api_key]` - _(required)_ API Key for Rackspace Load Balancers

`node[:newrelic][:rackspace_load_balancers][:region]` - _(required)_ Region for Rackspace Load Balancers. Valid values: `ord`, `dfw`, or `lon`
 
#### Usage: ####

    name "newrelic_rackspace_load_balancers_plugin"
    description "System that monitors Rackspace Load Balancers"
    run_list(
      "recipe[newrelic_plugins::rackspace_load_balancers]"
    )
    default_attributes(
      "newrelic" => {
        "license_key" => "NEW_RELIC_LICENSE_KEY",
        "rackspace_load_balancers" => {
          "install_path" => "/path/to/plugin",
          "user"         => "newrelic",
          "username"     => "RACKSPACE_USERNAME",
          "api_key"      => "RACKSPACE_API_KEY",
          "region"       => "dfw"
        }
      }
    )

For additional info, see https://github.com/newrelic-platform/newrelic_rackspace_load_balancers_plugin

## Wikipedia Example Java Plugin

#### Attributes: ####
 
 `node[:newrelic][:license_key]` - _(required)_ New Relic License Key
 
 `node[:newrelic][:wikipedia_example_java][:install_path]` -  _(required)_ Install directory. Defaults to `/opt/newrelic`. Any downloaded files will be placed here. The plugin will be installed within this directory at `newrelic_wikipedia_example_java_plugin`.
 
 `node[:newrelic][:wikipedia_example_java][:user]` - _(required)_ User to run as.

#### Usage: ####

    name "newrelic_wikipedia_example_java_plugin"
    description "System that monitors Wikipedia"
    run_list(
      "recipe[newrelic_plugins::wikipedia_example_java]"
    )
    default_attributes(
      "newrelic" => {
        "license_key" => "NEW_RELIC_LICENSE_KEY",
        "wikipedia_example_java" => {
          "install_path" => "/path/to/plugin",
          "user" => "newrelic"
        }
      }
    )
    
For additional info, see https://github.com/newrelic-platform/newrelic_java_wikipedia_plugin

## Wikipedia Example Ruby Plugin

#### Attributes: ####
 
 `node[:newrelic][:license_key]` - _(required)_ New Relic License Key
 
 `node[:newrelic][:wikipedia_example_ruby][:install_path]` -  _(required)_ Install directory. Defaults to `/opt/newrelic`. Any downloaded files will be placed here. The plugin will be installed within this directory at `newrelic_wikipedia_example_ruby_plugin`.
 
 `node[:newrelic][:wikipedia_example_ruby][:user]` - _(required)_ User to run as.

#### Usage: ####

    name "newrelic_wikipedia_example_ruby_plugin"
    description "System that monitors Wikipedia"
    run_list(
      "recipe[newrelic_plugins::wikipedia_example_ruby]"
    )
    default_attributes(
      "newrelic" => {
        "license_key" => "NEW_RELIC_LICENSE_KEY",
        "wikipedia_example_ruby" => {
          "install_path" => "/path/to/plugin",
          "user" => "newrelic"
        }
      }
    )

For additional info, see https://github.com/newrelic-platform/newrelic_wikipedia_plugin

## License ##

This cookbook is under the included MIT License.

## Contact ##

Contribute to this Cookbook at https://github.com/newrelic-platform/newrelic_plugins_chef. Any other feedback or support related questions can be sent to support @ newrelic.com. 