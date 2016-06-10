# cf) https://h2o.examp1e.net/install.html
case node[:platform]
when 'debian', 'ubuntu', 'mint'
  package 'wget'
  package 'cmake'
else
  package 'wget'
  package 'cmake'
end
