require 'bundler/setup'
require 'rspec'
require 'simplecov'

SimpleCov.start

# Require all files in lib
Dir[File.expand_path('../../lib/*', __FILE__)].each do |file|
  require file
end
