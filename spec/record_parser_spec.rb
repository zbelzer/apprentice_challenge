require_relative 'spec_helper'

describe RecordParser do
  describe "parse" do
    it "does not explode" do
      file = "notafilereally"
      parser = RecordParser.new(file)
      parser.parse
    end
  end
end
