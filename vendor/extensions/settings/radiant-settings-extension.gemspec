# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{radiant-settings-extension}
  s.version = "1.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alex Wayne", "Jim Gay", "Andrew vonderLuft"]
  s.date = %q{2011-04-21}
  s.description = %q{Allows users to edit the details of the config table.}
  s.email = %q{jim@saturnflyer.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "HELP_admin.md",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "app/controllers/admin/settings_controller.rb",
    "app/helpers/admin/settings_helper.rb",
    "app/views/admin/settings/_form.html.haml",
    "app/views/admin/settings/_setting.html.haml",
    "app/views/admin/settings/edit.html.haml",
    "app/views/admin/settings/index.html.haml",
    "app/views/admin/settings/new.html.haml",
    "config/locales/de.yml",
    "config/locales/en.yml",
    "config/locales/nl.yml",
    "config/locales/ru.yml",
    "config/routes.rb",
    "cucumber.yml",
    "db/migrate/001_add_description_to_config.rb",
    "db/migrate/002_add_settings_roles.rb",
    "features/support/env.rb",
    "features/support/paths.rb",
    "lib/permission_find_all_as_tree.rb",
    "lib/config_protection.rb",
    "lib/settings_tags.rb",
    "lib/tasks/settings_extension_tasks.rake",
    "public/images/extensions/settings/setting.png",
    "radiant-settings-extension.gemspec",
    "settings_extension.rb",
    "spec/controllers/admin/settings_controller_spec.rb",
    "spec/helpers/admin/settings_helper_spec.rb",
    "spec/lib/radiant/admin_ui_spec.rb",
    "spec/lib/settings_tags_spec.rb",
    "spec/models/config_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    "spec/views/admin/settings/edit_view_spec.rb",
    "spec/views/admin/settings/index_view_spec.rb"
  ]
  s.homepage = %q{https://github.com/saturnflyer/radiant-settings}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Settings Extension for Radiant CMS}
  s.test_files = [
    "spec/controllers/admin/settings_controller_spec.rb",
    "spec/helpers/admin/settings_helper_spec.rb",
    "spec/lib/radiant/admin_ui_spec.rb",
    "spec/lib/settings_tags_spec.rb",
    "spec/models/config_spec.rb",
    "spec/spec_helper.rb",
    "spec/views/admin/settings/edit_view_spec.rb",
    "spec/views/admin/settings/index_view_spec.rb"
  ]

  if s.respond_to? :specification_version then
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
