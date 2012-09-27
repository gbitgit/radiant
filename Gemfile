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
gem "mongrel","~>1.2.0.pre2"
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

#gem "screw-unit",:git=>'git://github.com/nathansobo/screw-unit.git'

#gem "devise"
#gem "cancan"
#gem "warden"

gem "multi_json","1.3.2"
gem "radiant","~> 1.0.1"
gem "rubypants"
gem "sass"
gem "uuidtools"
gem "cucumber"
gem 'cucumber-rails'#,     '0.3.2'
gem "factory_girl"
gem "execjs"
gem "therubyracer", :require => 'v8'
#gem "therubyracer", "~> 0.8.2.pre" #bleeding edge.
gem "grape"


gem "jsonify"
gem "jsonify-rails"
gem "meta_search"

#gem 'memcache-client'
#gem 'dalli',:git => 'git://github.com/mperham/dalli.git'

#gem "nokogiri"
#gem "awesome_nested_set", :git => 'git://github.com/collectiveidea/awesome_nested_set.git', :branch => "rails2"#, :tag => "1.4.4"
#gem 'bitmask_attributes', :git => 'git://github.com/joelmoss/bitmask_attributes.git', :tag => "v0.1.0"#, :branch => "master"
#gem "gabrielhase-bitmask-attribute", "~> 1.0.2"

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
gem "jeweler"
#gem "rspec"

#gem "thinking-sphinx",:git=>'git://github.com/freelancing-god/thinking-sphinx.git'

#gem "simple_form"
#gem "recordselect_vho",:git =>'git://github.com/vhochstein/recordselect.git'

#gem "kramdown"#representation filter - generate LaTex,PDF from HTML,kramdown,

gem "radiant-dashboard-extension"#,:path=> 'http://github.com/saturnflyer/radiant-dashboard-extension.git'
#gem "custom_scaffold",:git=> "git://github.com/vltsu/custom_scaffold.git"
gem "radiant-sheets-extension"#, :git => 'git://github.com/saturnflyer/radiant-sheets-extension.git'
#gem "radiant-clipped-extension"#,"1.0.17"#, :git => 'git://github.com/saturnflyer/radiant-sheets-extension.git'


gem 'linecache19', :git => 'git://github.com/mark-moseley/linecache', :group => [:development, :test]
gem 'ruby-debug-base19x', '~> 0.11.30.pre4', :group => [:development, :test]
gem 'ruby-debug19', :require => 'ruby-debug', :group => [:development, :test]

gem 'ruby-prof'
#gem 'perftools.rb'#, :git => 'git://github.com/tmm1/perftools.rb.git'
gem 'seed-fu'#, '~> 1.2.0' ,:git =>'git://github.com/mbleigh/seed-fu.git'

#preffered use = 'activeadmin'
#gem 'activeadmin'
#gem "merb-admin", "~> 0.8.8"

########## Permission for
gem "sequel", :git=>'git://github.com/jeremyevans/sequel.git'#,:tag=>""
gem "sequel_pg"
gem "arel" ,:git => 'git://github.com/rails/arel.git', :tag=>"v2.2.3"

# for demo purpose
gem 'declarative_authorization', :git => 'git://github.com/Orphist/declarative_authorization.git'

#########################
group :assets do
  #gem 'sass-rails'#,   '~> 3.2.3'
  #gem 'coffee-rails'#, '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
  #gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'
  #gem 'jquery-ui-rails'

end

# When radiant is installed as a gem you can run all of
# its tests and specs from an instance. If you're working
# on radiant itself and you want to run specs from the 
# radiant root directory, uncomment the line below and 
# run `bundle install`.

# gemspec
group :development do
#  gem 'erb2haml'
#  gem 'haml-rails'
#  gem 'hpricot'
  gem 'ruby_parser'
  gem 'erubis'
#git clone git://github.com/cowboyd/therubyracer.git .git_local/therubyracer
#cd .git_local/therubyracer
#git submodule update --init
#bundle install
#rake compile

    gem 'rspec',              '1.3.0'
    gem 'rspec-rails',        '1.3.2'
    gem 'database_cleaner',   '0.4.3'
    gem 'webrat',             '0.7.1'
    gem 'rr',                 '0.10.11'
  
end

if ENV['TRAVIS']
  gemspec :development_group => :test
  gem "pg"
end

