# Macros to help with fixtures
module FixtureMacros
  # Path to the fixtures directory
  SAMPLE_ROOT = File.expand_path('../../fixtures', __FILE__)

  # Create a path to the fixture by name.
  def path_to_fixture(fixture_name)
    Pathname.new(File.join(SAMPLE_ROOT, fixture_name))
  end

  # Get a sample line from a fixture
  #
  # Refactoring Opportunity:
  # Take an Integer or a Range for line. Also, if line is Nil, assume all rows.
  def sample_from_fixture(fixture_name, line)
    path = path_to_fixture(fixture_name)
    File.readlines(path)[line]
  end

  def einstein 
    {:LastName => "Einstein", :FirstName => "Albert",  :Gender => "Male", :FavoriteColor => "Green", :DateOfBirth => Date.parse("1879-03-14")}
  end

  def darwin   
    {:LastName => "Darwin", :FirstName => "Charles", :Gender => "Male", :FavoriteColor => "Blue", :DateOfBirth => Date.parse("1809-02-12")}
  end

  def curie    
    {:LastName => "Curie", :FirstName => "Marie", :Gender => "Female", :FavoriteColor => "Yellow", :DateOfBirth => Date.parse("1867-11-07")}
  end

  def lovelace 
    {:LastName => "Lovelace", :FirstName => "Ada", :Gender => "Female", :FavoriteColor => "Purple", :DateOfBirth => Date.parse("1815-12-10")}
  end

  def turing   
    {:LastName => "Turing", :FirstName => "Alan", :Gender => "Male", :FavoriteColor => "Green", :DateOfBirth => Date.parse("1912-06-03")}
  end
end

RSpec.configure { |config| config.include(FixtureMacros) }
