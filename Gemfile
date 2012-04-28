source :rubygems
source 'http://gemcutter.org'
#source 'https://github.com'

# This is the minimum of dependency required to run 
# the radiant instance generator, which is (normally)
# the only time the radiant gem functions as an 
# application. The instance has its own Gemfile, which
# requires radiant and therefore pulls in every 
# dependency mentioned in radiant.gemspec.

gem "rails",   "2.3.14"
gem "pg"
gem "mongrel"
gem "mongrel_cluster"
gem "rdoc"#,          "~> 3.9.2"
gem "acts_as_tree"#,  "~> 0.1.1"
gem "bundler"#,       "~> 1.0.0"
gem "compass"#,       "~> 0.11.1"
gem "delocalize"#,    "~> 0.2.3"
gem "haml"#,          "~> 3.1.1"
gem "highline"#,      "1.6.2"
gem "rack"#,          "~> 1.1.1"
gem "rack-cache"#,    "~> 1.0.2"
gem "rake",          "= 0.8.7"
gem "radius"#,  "~> 0.7.1"
gem "will_paginate", "~>2.3.16"
gem "stringex"#,      "~> 1.3.0"
gem "delocalize"
gem "RedCloth"
gem "bluecloth"

#gem "devise"
#gem "cancan"
#gem "warden"

#gem "multi_json"
gem "radiant","~> 1.0.1"
gem "rubypants"
gem "sass"
gem "uuidtools"
gem "cucumber"
gem "factory_girl"

#gem 'ruby-debug-base19'#, "0.11.24"
#gem 'ruby-debug19'#, "0.11.6"
gem 'ruby-prof'
#gem 'perftools.rb'#, :git => 'git://github.com/tmm1/perftools.rb.git'

#gem 'memcache-client'
#gem 'dalli',:git => 'git://github.com/mperham/dalli.git'

gem "nokogiri"
#gem "awesome_nested_set", :git => 'git://github.com/collectiveidea/awesome_nested_set.git', :branch => "rails2"#, :tag => "1.4.4"
#gem 'bitmask_attributes', :git => 'git://github.com/joelmoss/bitmask_attributes.git', :tag => "v0.1.0"#, :branch => "master"
#gem "gabrielhase-bitmask-attribute", "~> 1.0.2"
gem "arel" ,:git => 'git://github.com/rails/arel.git', :branch=>"v2.2.3"
#gem "tinymce" ,:git => 'git://github.com/gramos/easy-fckeditor.git'

#gem "active_scaffold_sortable" #,:git => 'git://github.com/vhochstein/active_scaffold_sortable.git', :branch=>"old"
#gem "active_scaffold_export" #,:git => 'git://github.com/vhochstein/active_scaffold_export.git', :branch=>"rails-old"
#gem 'active_scaffold_export_vho', :git => 'git://github.com/vhochstein/active_scaffold_export.git', :branch => 'rails-old'
#gem "active_scaffold_sortable",:git => 'git://github.com/activescaffold/active_scaffold_sortable.git', :branch=>"old"

#gem "active_scaffold" ,:git => 'git://github.com/vhochstein/active_scaffold.git', :branch=>"rails-2.3"
#gem "render_component" ,:git => 'git://github.com/ewildgoose/render_component.git', :branch=>"rails-2.3"
#gem "auto_complete", :git => 'git://github.com/rails/auto_complete.git'

#gem "ginger"
#gem "yard"
#gem "jeweler"
#gem "rspec"

#gem "thinking-sphinx",:git=>'git://github.com/freelancing-god/thinking-sphinx.git'

#gem "simple_form"
#gem "recordselect_vho",:git =>'git://github.com/vhochstein/recordselect.git'

#gem "kramdown"#representation filter - generate LaTex,PDF from HTML,kramdown,

gem "radiant-dashboard-extension"#,:path=> 'http://github.com/saturnflyer/radiant-dashboard-extension.git'
#gem "custom_scaffold",:git=> "git://github.com/vltsu/custom_scaffold.git"
gem "radiant-sheets-extension"#, :git => 'git://github.com/saturnflyer/radiant-sheets-extension.git'

# When radiant is installed as a gem you can run all of
# its tests and specs from an instance. If you're working
# on radiant itself and you want to run specs from the 
# radiant root directory, uncomment the line below and 
# run `bundle install`.

# gemspec
group :development do
#  gem 'erb2haml'
#  gem 'haml-rails'
  gem 'hpricot'
  gem 'ruby_parser'
  gem 'erubis'
end

if ENV['TRAVIS']
  gemspec :development_group => :test
  gem "pg"
end

