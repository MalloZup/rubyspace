require 'rubygems'
require 'bundler'
task :default => [:lint]

task :lint do
  gem 'rubocop'
  sh 'rubocop test/*.rb'
end
