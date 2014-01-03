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
  SUPPORTED_SEPARATORS = [',', '|', "\t"]

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
  # @return [Array<Hash>]
  def parse(options={})
    sort_options = options[:sort]

    rows = parse_rows(data)
    sort_rows(rows, sort_options)
  end

  # Sort the given row data based on the given options.
  #
  # @param [Array] sorts
  # @return [Array<Hash>]
  def sort_rows(rows, sorts)
    return rows if sorts.nil? || sorts.empty?

    sort = sorts.first

    rows.sort do |a, b|
      col, order = sort

      result = a[col] <=> b[col]

      if result == 0 # Tie
      else
        order == :asc ? result : -result
      end
    end
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

  # Do the actual parsing of the data.
  # 
  # If we have time, this can be pulled out into an object.
  #
  # @param [String] data
  # @return [Array<Hash>]
  def parse_rows(data)
    csv_options = DEFAULT_OPTIONS.merge(:col_sep => inferred_separator)
    CSV.parse(data, csv_options).map(&:to_hash)
  end
  private :parse_rows
end
