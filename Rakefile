#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rubygems'
require 'rake'
require "rspec/core/rake_task"

desc "Run RSpec"
task :default => :spec
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/r2do/*_spec.rb" 
end