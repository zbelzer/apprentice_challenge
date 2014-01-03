# Macros to help with fixtures
module FixtureMacros
  # Path to the fixtures directory
  SAMPLE_ROOT = File.expand_path('../../fixtures', __FILE__)

  # Create a path to the fixture by name.
  def path_to_fixture(fixture_name)
    Pathname.new(File.join(SAMPLE_ROOT, fixture_name))
  end

  # Get a sample line from a fixture
  def sample_from_fixture(fixture_name, line)
    path = path_to_fixture(fixture_name)
    File.readlines(path)[line]
  end
end

RSpec.configure { |config| config.include(FixtureMacros) }
