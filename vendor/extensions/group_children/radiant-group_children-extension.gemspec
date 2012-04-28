# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{radiant-group_children-extension}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Benny Degezelle"]
  s.date = %q{2010-09-25}
  s.description = %q{Adds the ability to iterate over a page's children per n items.}
  s.email = %q{benny@gorilla-webdesign.be}
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "README.md",
     "Rakefile",
     "VERSION",
     "config/locales/en.yml",
     "config/routes.rb",
     "cucumber.yml",
     "features/support/env.rb",
     "features/support/paths.rb",
     "group_children_extension.rb",
     "lib/group_tags.rb",
     "lib/tasks/group_children_extension_tasks.rake",
     "radiant-group_children-extension.gemspec",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/jomz/radiant-group_children-extension}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Group Children Extension for Radiant CMS}
  s.test_files = [
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<radiant>, [">= 0.9.1"])
    else
      s.add_dependency(%q<radiant>, [">= 0.9.1"])
    end
  else
    s.add_dependency(%q<radiant>, [">= 0.9.1"])
  end
end

