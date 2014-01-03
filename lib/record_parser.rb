require 'csv'

# Entry point for RecordParsing
class RecordParser
  # Mandatory options expected by the parser.
  DEFAULT_OPTIONS = {
    :headers           => true,
    :header_converters => lambda {|h| h.strip.to_sym},
    :converters        => lambda {|h| h.strip}
  }

  # Separators supported by the parser.
  SUPPORTED_SEPARATORS = %w(,)

  # To be raised when the given file cannot be found.
  class FileNotFound < RuntimeError
    def initialize(path)
      super "Could not find a file at the path '#{path}'"
    end
  end

  # To be raised when we cannot determine the file format.
  class UnknownFormat < RuntimeError
    def initialize(path)
      super "Could not determine the format of '#{path}'"
    end
  end

  # Create a new parser initialized with a source file.
  #
  # @param [String,Pathname] path Path to a file to read
  def initialize(path)
    @path = path.to_s
  end

  # Parse the current file in to a set of records.
  #
  # @param [Hash] options
  def parse(options={})
    csv_options = options.merge(DEFAULT_OPTIONS)
    csv_options.update(:col_sep => inferred_separator)

    CSV.parse(data, csv_options).map(&:to_hash)
  end

  # Get the raw data of the file as a string.
  #
  # @raise RecordParser::FileNotFound
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

  # Infer the separator based on the data (naive but hey).
  #
  # @raise RecordParser::UnknownFormat
  #
  # @return [String]
  def inferred_separator
    SUPPORTED_SEPARATORS.each do |sep|
      return sep if data.scan(sep).length > 0
    end

    raise UnknownFormat.new(@path)
  end
end
