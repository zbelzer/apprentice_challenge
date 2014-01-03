require_relative 'spec_helper'

describe RecordPrinter do
  describe "print" do
    it "sorts by given columns" do
      rows = [
        {:a => 1, :b => 2, :c => 3},
        {:a => 4, :b => 5, :c => 6},
      ]

      printer = RecordPrinter.new(rows)
      result = printer.print(:b, :c, :a)
      expect(result).to eq("b,c,a\n2,3,1\n5,6,4")
    end

    it "formats dates correctly" do
      rows = [{:a => Date.parse("1985-01-08")}]

      printer = RecordPrinter.new(rows)
      result = printer.print(:a)
      expect(result).to eq("a\n01/08/1985")
    end
  end
end
