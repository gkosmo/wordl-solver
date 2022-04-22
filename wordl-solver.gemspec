# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: wordl-solver 0.2.3 ruby lib

Gem::Specification.new do |s|
  s.name = "wordl-solver".freeze
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["george kosmopoulos".freeze]
  s.date = "2022-04-22"
  s.description = "This gem helps you solve wordl puzzles. It does so by asking you for the letters position you know, the letters you know exists and the ones you know don't exists. It then proposes words depending on how good they are by weighting the letters by their frequency in the english language.".freeze
  s.email = "gkosmo1@hotmail.com".freeze
  s.executables = ["wordl-solver".freeze]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/wordl-solver",
    "lib/5_words.csv",
    "lib/wordl-solver.rb",
    "wordl-solver.gemspec"
  ]
  s.homepage = "http://github.com/gkosmo/wordl-solver".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.10".freeze
  s.summary = "This gem solves wordl puzzles.".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<shoulda>.freeze, [">= 0"])
    s.add_development_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
  else
    s.add_dependency(%q<shoulda>.freeze, [">= 0"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
  end
end

