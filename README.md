# Itamae::Plugin::Recipe::H2o

[Itamae](https://github.com/ryotarai/itamae) plugin to install [H2O](https://h2o.examp1e.net)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-recipe-h2o'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-recipe-h2o

## Usage
## System wide installation

Install H2O to /usr/local

### Recipe

```ruby
# your recipe
include_recipe "h2o::install"
```

### Node

Use this with `itamae -y node.yml`

```yaml
# node.yml
h2o:
  version: 2.0.0
  
  # H2O install dir, optional (default: /usr/local)
  h2o_root: "/path/to/h2o"
  
  # `on` if H2O use bundled LibreSSL.
  bundled_ssl: on

  # `on` if H2O use mruby.
  mruby: on
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

