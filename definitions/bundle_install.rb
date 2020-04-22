define :bundle_install do
  # install bundler gem
  gem_package 'bundler' do
    options '--no-ri --no-rdoc'
  end

  # bundle install
  execute 'bundle install' do
    cwd params[:path]
    if params[:user] == 'root'
      command 'bundle install'
    else
      command 'bundle install --path vendor/bundle'
    end
    user params[:user]
    only_if { File.directory?(params[:path]) }
  end
end
