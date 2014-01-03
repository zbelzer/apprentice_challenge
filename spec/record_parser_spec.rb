require_relative 'spec_helper'

describe RecordParser do
  describe "parse" do
    let(:correct_result) do
      [
        {:last_name => "Einstein", :first_name => "Albert",  :gender => "Male",   :favorite_color => "Green",  :date_of_birth => "03/14/1879"},
        {:last_name => "Darwin",   :first_name => "Charles", :gender => "Male",   :favorite_color => "Blue",   :date_of_birth => "02/12/1809"},
        {:last_name => "Curie",    :first_name => "Marie",   :gender => "Female", :favorite_color => "Yellow", :date_of_birth => "11/07/1867"},
        {:last_name => "Lovelace", :first_name => "Ada",     :gender => "Female", :favorite_color => "Purple", :date_of_birth => "12/10/1815"},
        {:last_name => "Turing",   :first_name => "Alan",    :gender => "Male",   :favorite_color => "Red",    :date_of_birth => "06/03/1912"}
      ]
    end

    it "parses a CSV file" do
      file = path_to_fixture('test.csv')
      parser = RecordParser.new(file)
      expect(parser.parse).to eql(correct_result)
    end
  end
end
