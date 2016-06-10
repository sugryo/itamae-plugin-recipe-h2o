include_recipe 'h2o::dependency'

version = node[:h2o][:version]

remote_file "/tmp/h2o-#{version}.tar.gz" do
  source "https://github.com/h2o/h2o/archive/v#{version}.tar.gz"
end

execute 'Unzip Tar file' do
  command "tar xzvf h2o-#{version}.tar.gz"
  cwd "/tmp"
  not_if "test -e /tmp/h2o#{version}.tar.gz"
end

execute 'Cmake a h2o' do
  options = []
  case node[:h2o][:bundled_ssl]
  when 'on'
    options << ' -DWITH_BUNDLED_SSL=on'
  when 'off'
    options << ' -DWITH_BUNDLED_SSL=off'
  else
    # Default: off if OpenSSL version >= 1.0.2 is found, on if otherwise.
  end

  case node[:h2o][:mruby]
  when 'on'
    options << ' -DWITH_MRUBY=on'
  when 'off'
    options << ' -DWITH_MRUBY=off'
  else
    # Default: on if bison, ruby and development files is found, off if otherwise.
  end

  install_prefix ||= node[:h2o][:install_prefix]
  options << " -DCMAKE_INSTALL_PREFIX=#{install_prefix}" if install_prefix
  
  command "cmake #{options.join}"
  cwd "/tmp/h2o-#{version}"
  not_if "test -e /tmp/h2o-#{version}"
end

execute 'Make a h2o' do
  if node[:platform] == 'osx' && node[:platform] == 'darwin'
    command "make -j$(/usr/sbin/sysctl -n hw.ncpu)"
  else
    command "make -j$(grep '^processor' /proc/cpuinfo | wc -l)"
  end
  cwd "/tmp/h2o-#{version}"
  not_if "test -e /tmp/h2o-#{version}"
end

execute 'Install a h2o' do
  command 'sudo make install'
  cwd "/tmp/h2o-#{version}"
  not_if "test -e /tmp/h2o-#{version}"
end
