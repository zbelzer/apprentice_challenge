require_relative 'spec_helper'

describe RecordPrinter do
  describe "print" do
    it "does not fail" do
      rows = []
      printer = RecordPrinter.new(rows)
      printer.print({})
    end
  end
end
