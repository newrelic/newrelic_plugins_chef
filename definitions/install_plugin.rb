define :install_plugin do

  tar_file = File.join(params[:install_path], "#{params[:name]}-#{params[:plugin_version]}.tar.gz")

  # create install path
  directory params[:install_path] do
    owner params[:user]
    action :create
    recursive true
  end

  # download plugin tar file
  remote_file tar_file do
    source params[:download_url]
    action :create_if_missing
    owner params[:user]
    notifies :delete, "directory[#{params[:plugin_path]}]", :immediately
    notifies :create, "directory[#{params[:plugin_path]}]", :immediately
    notifies :run, "bash[extract #{params[:name]} resource]", :immediately
    not_if { File.exist?(tar_file) }
  end

  directory params[:plugin_path] do
    action :create
    recursive true
    owner params[:user]
  end

  # extract plugin tar file to params[:plugin_path]
  # if not using gzipped tars, the tar command may be different
  bash "extract #{params[:name]} resource" do
    cwd params[:plugin_path]
    code <<-EOH
      tar zxvf #{tar_file} --strip-components=1
    EOH
    user params[:user]
    # directory is empty if it has 2 entries (implicit . and .. entries)
    only_if { File.directory?(params[:plugin_path]) && Dir.entries(params[:plugin_path]).sort == %w(. ..) }
  end

end