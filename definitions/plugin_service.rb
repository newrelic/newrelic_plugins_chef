define :plugin_service do
  # create init.d script
  template "/etc/init.d/#{params[:name]}" do
    source 'service.erb'
    variables({
      :daemon       => params[:daemon],
      :daemon_dir   => params[:daemon_dir],
      :plugin_name  => params[:plugin_name],
      :user         => params[:user],
      :run_command  => params[:run_command],
      :service_name => params[:name],
      :version      => params[:plugin_version]
    })
    action :create
    mode 0755
  end

  # manage service
  service params[:name] do
    action [:enable, :start]
    subscribes :restart, "template[/etc/init.d/#{params[:name]}]", :immediately
  end
end