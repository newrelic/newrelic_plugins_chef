define :verify_java do
  ohai "reload" do
    action :reload
  end
  ruby_block "verify java for #{params[:name]}" do
    block do
      # check java dependency
      unless node[:languages][:java] && node[:languages][:java][:version].start_with?('1.6', '1.7', '1.8')
        Chef::Application.fatal!("The New Relic #{params[:name]} requires a Java version >= 1.6 -" +
          " For more information, see https://docs.newrelic.com/docs/plugins/installing-a-plugin")
      end
    end
  end
end