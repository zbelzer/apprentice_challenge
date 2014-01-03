require 'rspec'
require 'simplecov'

SimpleCov.start

require_relative '../lib/record_parser'

describe RecordParser do
  describe "parse" do
    it "does not explode" do
      file = "notafilereally"
      parser = RecordParser.new(file)
      parser.parse
    end
  end
end
