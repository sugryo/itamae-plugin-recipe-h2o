# cf) https://h2o.examp1e.net/install.html
p node[:h2o][:mruby]
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
