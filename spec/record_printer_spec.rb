require_relative 'spec_helper'

describe RecordPrinter do
  let(:rows) do
    [
      {:a => 1, :b => 2, :c => 3},
      {:a => 4, :b => 5, :c => 6},
    ]
  end

  describe "print" do
    it "sorts by given columns" do
      printer = RecordPrinter.new(rows)
      result = printer.print(:b, :c, :a)
      expect(result).to eq("b,c,a\n2,3,1\n5,6,4")
    end
  end
end
