# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "c2dm_on_rails"
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Julius de Bruijn"]
  s.date = "2012-07-05"
  s.description = "C2DM on Rails is a Ruby on Rails gem that allows you to\neasily add Android Cloud to Device Messaging support to your Rails application.\n"
  s.email = "julius.debruijn@digia.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.textile"
  ]
  s.files = [
    "CHANGELOG",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "Manifest",
    "README.textile",
    "Rakefile",
    "VERSION",
    "c2dm_on_rails.gemspec",
    "lib/c2dm_on_rails.rb",
    "lib/c2dm_on_rails/app/models/c2dm/base.rb",
    "lib/c2dm_on_rails/app/models/c2dm/device.rb",
    "lib/c2dm_on_rails/app/models/c2dm/device_grouping.rb",
    "lib/c2dm_on_rails/app/models/c2dm/group.rb",
    "lib/c2dm_on_rails/app/models/c2dm/group_notification.rb",
    "lib/c2dm_on_rails/app/models/c2dm/notification.rb",
    "lib/c2dm_on_rails/c2dm_on_rails.rb",
    "lib/c2dm_on_rails/libs/connection.rb",
    "lib/c2dm_on_rails/tasks/c2dm.rake",
    "lib/c2dm_on_rails_tasks.rb",
    "lib/generators/c2dm_migrations_generator.rb",
    "lib/generators/templates/c2dm_migrations/create_c2dm_devices.rb",
    "lib/generators/templates/c2dm_migrations/create_c2dm_groups.rb",
    "lib/generators/templates/c2dm_migrations/create_c2dm_notifications.rb"
  ]
  s.homepage = "http://github.com/pimeys/c2dm_on_rails"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Android Cloud to Device Messaging (push notifications) on Rails"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jeweler>, [">= 0"])
      s.add_runtime_dependency(%q<configatron>, [">= 0"])
      s.add_runtime_dependency(%q<gdata_19>, [">= 0"])
    else
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<configatron>, [">= 0"])
      s.add_dependency(%q<gdata_19>, [">= 0"])
    end
  else
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<configatron>, [">= 0"])
    s.add_dependency(%q<gdata_19>, [">= 0"])
  end
end

