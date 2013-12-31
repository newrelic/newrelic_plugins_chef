define :bundle_install do
  # install bundler gem
  gem_package 'bundler' do
    options '--no-ri --no-rdoc'
  end

  bin_stubs = params[:bin_stubs] ? '--binstubs' : ''

  # bundle install
  execute 'bundle install' do
    cwd params[:path]
    command "bundle install #{bin_stubs}"
    user params[:user]
    only_if { File.directory?(params[:path]) }
  end
end