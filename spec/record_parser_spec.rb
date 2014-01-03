require_relative 'spec_helper'

describe RecordParser do
  describe "parse" do
    let(:correct_result) do
      [
        {:LastName => "Einstein", :FirstName => "Albert",  :Gender => "Male",   :FavoriteColor => "Green",  :DateOfBirth => "03/14/1879"},
        {:LastName => "Darwin",   :FirstName => "Charles", :Gender => "Male",   :FavoriteColor => "Blue",   :DateOfBirth => "02/12/1809"},
        {:LastName => "Curie",    :FirstName => "Marie",   :Gender => "Female", :FavoriteColor => "Yellow", :DateOfBirth => "11/07/1867"},
        {:LastName => "Lovelace", :FirstName => "Ada",     :Gender => "Female", :FavoriteColor => "Purple", :DateOfBirth => "12/10/1815"},
        {:LastName => "Turing",   :FirstName => "Alan",    :Gender => "Male",   :FavoriteColor => "Red",    :DateOfBirth => "06/03/1912"}
      ]
    end

    it "raises FileNotFound exception when given file does not exist" do
      expect {

        not_a_file = path_to_fixture('foo.csv')
        parser = RecordParser.new(not_a_file).parse
        parser.parse

      }.to raise_error(RecordParser::FileNotFound)
    end

    it "parses a CSV file" do
      file = path_to_fixture('test.csv')
      parser = RecordParser.new(file)
      expect(parser.parse).to eql(correct_result)
    end
  end
end
