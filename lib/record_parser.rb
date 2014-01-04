require 'csv'
require 'date'
require_relative 'record_sorter'

# Entry point for RecordParsing
class RecordParser
  # Assumed headers for incoming data.
  HEADERS = %w(LastName FirstName Gender FavoriteColor DateOfBirth)

  # Mandatory options expected by the parser.
  DEFAULT_OPTIONS = {
    :headers           => HEADERS,
    :header_converters => lambda {|h| h.strip.to_sym},
    :converters        => [lambda {|h| h.strip}, :date]
  }

  # Separators supported by the parser.
  SUPPORTED_SEPARATORS = [',', '|', "\t", " "]

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
  # Refactoring Opportunity:
  # Take data to be parsed and not just a path.
  #
  # @param [String,Pathname] path Path to a file to read
  def initialize(path)
    @path = path.to_s
  end

  # Parse the current file in to a set of records.
  #
  # Refactoring Opportunity:
  # Create a class method 'parse' that takes path and parsing options.
  #
  # @param [Hash] options
  # @return [Array<Hash>]
  def parse(options={})
    rows = parse_rows(data)
    sort_rows(rows, options[:sort])
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
  # Feature Opportunity:
  # Detect by file extension
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

  # Do the actual parsing of the data.
  # 
  # Refactoring Opportunity:
  # Pull this out into its own object like RecordSorter.
  #
  # @param [String] data
  # @return [Array<Hash>]
  def parse_rows(data)
    csv_options = DEFAULT_OPTIONS.merge(:col_sep => inferred_separator)
    CSV.parse(data, csv_options).map(&:to_hash)
  end
  private :parse_rows

  # Do the sorting of the rows
  #
  # @param [Array<Hash>] rows
  # @param [Array<Array(col,order)>] sorts
  #
  # @return [Array<Hash>]
  def sort_rows(rows, sorts)
    RecordSorter.new(rows).sort(sorts)
  end
  private :sort_rows
end
