require "rubygems"
require "bundler"
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  warn e.message
  warn "Run `bundle install` to install missing gems"
  exit e.status_code
end
require "rake"
require "juwelier"
Juwelier::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "wordl-solver"
  gem.homepage = "http://github.com/gkosmo/wordl-solver"
  gem.license = "MIT"
  gem.summary = "This gem solves wordl puzzles."
  gem.description = "This gem helps you solve wordl puzzles. It does so by asking you for the letters position you know, the letters you know exists and the ones you know don't exists. It then proposes words depending on how good they are by weighting the letters by their frequency in the english language."
  gem.email = "gkosmo1@hotmail.com"
  gem.authors = ["george kosmopoulos"]
  gem.files.include "lib/*"
  # dependencies defined in Gemfile
  gem.executables = ["wordl-solver"]
end
Juwelier::RubygemsDotOrgTasks.new
require "rake/testtask"
Rake::TestTask.new(:test) do |test|
  test.libs << "lib" << "test"
  test.pattern = "test/**/test_*.rb"
  test.verbose = true
end

desc "Code coverage detail"
task :simplecov do
  ENV["COVERAGE"] = "true"
  Rake::Task["test"].execute
end

task default: :test

require "rdoc/task"
Rake::RDocTask.new do |rdoc|
  version = File.exist?("VERSION") ? File.read("VERSION") : ""

  rdoc.rdoc_dir = "rdoc"
  rdoc.title = "wordl-solver #{version}"
  rdoc.rdoc_files.include("README*")
  rdoc.rdoc_files.include("lib/**/*.rb")
end
