# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: vcr-uri-catcher 0.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "vcr-uri-catcher"
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Mischa Molhoek"]
  s.date = "2015-03-20"
  s.description = "execute arbitrary code (like {raise RestClient::RequestTimeout}) the moment vcr tries to access certain configurable uri('s)"
  s.email = "mischamolhoek@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.MD"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "LICENSE.txt",
    "README.MD",
    "Rakefile",
    "VERSION",
    "features/cassettes/cucumber_tags/vcr.yml",
    "features/library.feature",
    "features/step_definitions/vcr-uri-catcher_steps.rb",
    "features/support/env.rb",
    "features/support/vcr.rb",
    "features/vcr-uri-catcher.feature",
    "lib/vcr-uri-catcher.rb",
    "test/helper.rb",
    "test/test_vcr-uri-catcher.rb",
    "vcr-uri-catcher.gemspec"
  ]
  s.homepage = "https://github.com/mmolhoek/vcr-uri-catcher"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.1"
  s.summary = "execute arbitrary code (like {raise RestClient::RequestTimeout}) the moment vcr tries to access certain configurable uri('s)"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<vcr>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<pry-nav>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<rest-client>, [">= 0"])
    else
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<vcr>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<pry-nav>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<rest-client>, [">= 0"])
    end
  else
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<vcr>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<pry-nav>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<rest-client>, [">= 0"])
  end
end

