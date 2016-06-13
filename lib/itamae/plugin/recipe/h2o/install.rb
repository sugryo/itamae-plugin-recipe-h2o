include_recipe 'h2o::dependency'

version = node[:h2o][:version]

execute 'Download a H2O' do
  command "wget https://github.com/h2o/h2o/archive/v#{version}.tar.gz"
  cwd "/tmp"
  not_if "test -e /tmp/v#{version}.tar.gz"
  not_if 'type h2o'
end

execute 'Unzip Tar file' do
  command "tar xzvf v#{version}.tar.gz"
  cwd "/tmp"
  not_if "test -e /tmp/h2o-#{version}"
  not_if 'type h2o'
end

execute 'Cmake a h2o' do
  options = []
  case node[:h2o][:bundled_ssl]
  when true
    options << ' -DWITH_BUNDLED_SSL=on'
  when false
    options << ' -DWITH_BUNDLED_SSL=off'
  else
    # Default: off if OpenSSL version >= 1.0.2 is found, on if otherwise.
  end

  if node[:h2o][:mruby]
    options << ' -DWITH_MRUBY=on'
  else
    options << ' -DWITH_MRUBY=off'
  end
  # Default: on if bison, ruby and development files is found, off if otherwise.

  install_prefix ||= node[:h2o][:install_prefix]
  options << " -DCMAKE_INSTALL_PREFIX=#{install_prefix}" if install_prefix
  
  
  command "cmake#{options.join} ."
  cwd "/tmp/h2o-#{version}"
  only_if "test -e /tmp/h2o-#{version}"
  not_if 'type h2o'
end

execute 'Make a h2o' do
  if node[:platform] == 'osx' && node[:platform] == 'darwin'
    command "make -j$(/usr/sbin/sysctl -n hw.ncpu)"
  else
    command "make -j$(grep '^processor' /proc/cpuinfo | wc -l)"
  end
  cwd "/tmp/h2o-#{version}"
  only_if "test -e /tmp/h2o-#{version}"
  not_if 'type h2o'
end

execute 'Install a h2o' do
  command 'sudo make install'
  cwd "/tmp/h2o-#{version}"
  only_if "test -e /tmp/h2o-#{version}"
  not_if 'type h2o'
end
