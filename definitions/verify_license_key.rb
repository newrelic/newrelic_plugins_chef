define :verify_license_key do
  unless /^[0-9a-fA-F]{40}$/ =~ params[:name]
    Chef::Application.fatal!("The provided New Relic License Key is invalid: #{params[:name]}." +
        " For more information, see https://docs.newrelic.com/docs/subscriptions/license-key")
  end
end