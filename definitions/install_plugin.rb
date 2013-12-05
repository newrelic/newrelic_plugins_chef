define :install_plugin do

  file_name      = "#{params[:name]}-#{params[:plugin_version]}"
  plugin_path    = "#{params[:install_path]}/#{file_name}"
  download_path  = "#{plugin_path}.tar.gz"

  # create install path
  directory params[:install_path] do
    action :create
    owner params[:user]
  end

  # download plugin tar file
  remote_file download_path do
    source params[:download_url]
    action :create_if_missing
    owner params[:user]
    not_if { File.directory?(plugin_path) }
  end

  # extract plugin tar file
  bash "extract #{params[:name]} resource" do
    cwd params[:install_path]
    code <<-EOH
      tar zxvf #{download_path}
    EOH
    user params[:user]
    not_if { File.directory?(plugin_path) }
  end

end