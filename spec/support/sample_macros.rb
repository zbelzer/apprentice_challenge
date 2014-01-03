# Macros to help with samples
module SampleMacros
  # Path to the samples directory
  SAMPLE_ROOT = File.expand_path('../../samples', __FILE__)

  # Create a path to the sample by name.
  def path_to_sample(sample_name)
    Pathname.new(File.join(SAMPLE_ROOT, sample_name))
  end
end

RSpec.configure { |config| config.include(SampleMacros) }
