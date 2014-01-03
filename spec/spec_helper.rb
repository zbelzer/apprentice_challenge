require 'bundler/setup'
require 'rspec'
require 'simplecov'
require 'rack/test'
require 'pry'

# Require all support files
Dir[File.expand_path('../support/*', __FILE__)].each do |file|
  require file
end

SimpleCov.start

# Require all files in lib
Dir[File.expand_path('../../lib/*', __FILE__)].each do |file|
  require file
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end
