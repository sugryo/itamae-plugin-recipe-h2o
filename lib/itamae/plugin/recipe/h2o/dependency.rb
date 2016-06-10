# cf) https://h2o.examp1e.net/install.html
case node[:platform]
when 'debian', 'ubuntu', 'mint'
  package 'wget'
  package 'cmake'
  if node[:h2o][:mruby]
    package 'bison'
    package 'ruby-dev'
  end
else
  package 'wget'
  package 'cmake'
  if node[:h2o][:mruby]
    package 'bison'
    package 'ruby'
  end
end
