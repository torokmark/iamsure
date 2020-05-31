require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec


task :build do
  system "gem build iamsure.gemspec"
end

task :install do
  system "gem install iamsure-#{ Iamsure::VERSION }.gem"
end

task :push do
  system "gem push iamsure-#{ Iamsure::VERSION }.gem"
end

task :exec do
  system './bin/iamsure'
end

task :full => [:build, :rspec, :install, :exec]