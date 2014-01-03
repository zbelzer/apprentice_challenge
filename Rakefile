#!/usr/bin/env rake

require 'bundler/setup' 
require 'rspec/core/rake_task'
require 'yard'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc "Check documentation coverage"
task :doc do
  YARD::CLI::Stats.run('--list-undoc')
end
