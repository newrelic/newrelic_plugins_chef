## New Relic Plugin's Cookbook ##

### Note: This Cookbook is currently in Beta ###

The cookbook will be moved to the Chef Community after the beta. To use the cookbook, clone or download this repo and add it to your Chef cookbooks path under the name `newrelic_plugins`. Follow the usage instructions below.

Please provide any feedback to <jstenhouse@newrelic.com> or create a pull request here. Thanks!

## Overview ##

This cookbook installs, configures and manages as a service New Relic Plugins on Debian/RHEL. 

Recipes for the following plugins are provided:

 - AWS Cloudwatch
 - MySQL
 - F5
 - Example (Ruby)

## Requirements ##

Chef 0.10.10+ and Ohai 6.10+ for `platform_family` support.

The AWS Cloudwatch, F5 and Example plugins require:

- Ruby >= 1.8.7 
- Rubygems >= 1.8

The MySQL plugin requires: 

- Java Runtime Environment (JRE) >= 1.6

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
          "servers" => [
            {
              "name"    => "Production 1",
              "host"    => "localhost",
              "metrics" => "status,newrelic",
              "user"    => "USER",
              "passwd"  => "PASSWORD"
            }
          ]
        }
      }
    )

## AWS Cloudwatch Plugin ##

#### Attributes: ####
 
 `node[:newrelic][:license_key]` - _(required)_ New Relic License Key
 
 `node[:newrelic][:aws_cloudwatch][:install_path]` -  _(required)_ Install Directory
 
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
 
 `node[:newrelic][:example][:install_path]` -  _(required)_ Install Directory
 
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
          "install_path" => "/path/to/plugin"
        }
      }
    )

For additional info, see https://github.com/newrelic-platform/newrelic_example_plugin

## F5 Plugin ##

#### Attributes: ####

 `node[:newrelic][:license_key]` - _(required)_ New Relic License Key
 
 `node[:newrelic][:f5][:install_path]` -  _(required)_ Install Directory
 
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

## MySQL Plugin ##

#### Attributes: ####
 
 `node[:newrelic][:license_key]` - _(required)_ New Relic License Key
 
 `node[:newrelic][:msyql][:install_path]` -  _(required)_ Install Directory
 
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
          "java_options" => "-Dhttps.proxyHost=proxy.example.com -Dhttps.proxyPort=12345",
          "servers" => [
            {
              "name"    => "Production Master",
              "host"    => "master-host",
              "metrics" => "status,newrelic,master",
              "user"    => "USER_NAME_HERE",
              "passwd"  => "USER_CLEAR_TEXT_PASSWORD_HERE"
            },
            {
              "name"    => "Production Slave",
              "host"    => "slave-host",
              "metrics" => "status,newrelic,slave",
              "user"    => "USER_NAME_HERE",
              "passwd"  => "USER_CLEAR_TEXT_PASSWORD_HERE"
            }
          ]
        }
      }
    )

For additional info, see https://github.com/newrelic-platform/newrelic_mysql_java_plugin

## License ##

This cookbook is under the included MIT License.

## Contact ##

Contribute to this Cookbook at https://github.com/newrelic-platform/newrelic_plugins_chef. Any other feedback or support related questions can be sent to support @ newrelic.com. 