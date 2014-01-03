require_relative 'spec_helper'

describe RecordParser do
  describe "parse" do
    it "parses a CSV file" do
      file = path_to_sample('test.csv')

      parser = RecordParser.new(file)
      parser.parse
    end
  end
end
