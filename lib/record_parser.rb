require 'csv'

# Entry point for RecordParsing
class RecordParser
  DEFAULT_OPTIONS = {
    :headers => true,
    :header_converters => lambda {|h| h.strip.to_sym},
    :converters => lambda {|h| h.strip}
  }

  # To be raised when the given file cannot be found.
  class FileNotFound < RuntimeError
    def initialize(path)
      super "Could not find a file at the path '#{path}'"
    end
  end

  # Create a new parser initialized with a source file.
  #
  # @param [String,Pathname] file Path to a file to read
  def initialize(path)
    @path = path.to_s
  end

  # Parse the current file in to a set of records.
  #
  # @param [Hash] options
  def parse(options={})
    CSV.parse(data, options.merge(DEFAULT_OPTIONS)).map(&:to_hash)
  end

  # Get the raw data of the file as a string.
  #
  # @raises RecordParser::FileNotFound
  #
  # @return [String]
  def data
    return @data unless @data.nil?

    if File.exists?(@path)
      @data = File.read(@path)
    else
      raise FileNotFound.new(@path)
    end
  end
  private :data
end
