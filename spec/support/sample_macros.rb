# Macros to help with fixtures
module FixtureMacros
  # Path to the fixtures directory
  SAMPLE_ROOT = File.expand_path('../../fixtures', __FILE__)

  # Create a path to the fixture by name.
  def path_to_fixture(fixture_name)
    Pathname.new(File.join(SAMPLE_ROOT, fixture_name))
  end
end

RSpec.configure { |config| config.include(FixtureMacros) }
