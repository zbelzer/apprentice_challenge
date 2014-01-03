require_relative 'spec_helper'

describe RecordParser do
  describe "parse" do
    context "extraction" do
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

      it "raises UnknownFormat when trying to parse unknown file format" do
        expect {

          file = path_to_fixture('test.bsv')
          parser = RecordParser.new(file)
          parser.parse

        }.to raise_error(RecordParser::UnknownFormat)
      end

      it "parses a CSV file" do
        file = path_to_fixture('test.csv')
        parser = RecordParser.new(file)
        expect(parser.parse).to eql(correct_result)
      end

      it "parses a TSV file" do
        file = path_to_fixture('test.tsv')
        parser = RecordParser.new(file)
        expect(parser.parse).to eql(correct_result)
      end

      it "parses a PSV file" do
        file = path_to_fixture('test.psv')
        parser = RecordParser.new(file)
        expect(parser.parse).to eql(correct_result)
      end
    end

    context "sorting" do
      let(:parser) { RecordParser.new(path_to_fixture('test.csv')) }

      let(:gender_then_last_name) do
        [
          {:LastName => "Curie",    :FirstName => "Marie",   :Gender => "Female", :FavoriteColor => "Yellow", :DateOfBirth => "11/07/1867"},
          {:LastName => "Lovelace", :FirstName => "Ada",     :Gender => "Female", :FavoriteColor => "Purple", :DateOfBirth => "12/10/1815"},
          {:LastName => "Darwin",   :FirstName => "Charles", :Gender => "Male",   :FavoriteColor => "Blue",   :DateOfBirth => "02/12/1809"},
          {:LastName => "Einstein", :FirstName => "Albert",  :Gender => "Male",   :FavoriteColor => "Green",  :DateOfBirth => "03/14/1879"},
          {:LastName => "Turing",   :FirstName => "Alan",    :Gender => "Male",   :FavoriteColor => "Red",    :DateOfBirth => "06/03/1912"}
        ]
      end

      let(:birthdate_asc) do
        [
          {:LastName => "Darwin",   :FirstName => "Charles", :Gender => "Male",   :FavoriteColor => "Blue",   :DateOfBirth => "02/12/1809"},
          {:LastName => "Lovelace", :FirstName => "Ada",     :Gender => "Female", :FavoriteColor => "Purple", :DateOfBirth => "12/10/1815"},
          {:LastName => "Curie",    :FirstName => "Marie",   :Gender => "Female", :FavoriteColor => "Yellow", :DateOfBirth => "11/07/1867"},
          {:LastName => "Einstein", :FirstName => "Albert",  :Gender => "Male",   :FavoriteColor => "Green",  :DateOfBirth => "03/14/1879"},
          {:LastName => "Turing",   :FirstName => "Alan",    :Gender => "Male",   :FavoriteColor => "Red",    :DateOfBirth => "06/03/1912"}
        ]
      end

      let(:last_name_desc) do
        [
          {:LastName => "Turing",   :FirstName => "Alan",    :Gender => "Male",   :FavoriteColor => "Red",    :DateOfBirth => "06/03/1912"},
          {:LastName => "Lovelace", :FirstName => "Ada",     :Gender => "Female", :FavoriteColor => "Purple", :DateOfBirth => "12/10/1815"},
          {:LastName => "Einstein", :FirstName => "Albert",  :Gender => "Male",   :FavoriteColor => "Green",  :DateOfBirth => "03/14/1879"},
          {:LastName => "Darwin",   :FirstName => "Charles", :Gender => "Male",   :FavoriteColor => "Blue",   :DateOfBirth => "02/12/1809"},
          {:LastName => "Curie",    :FirstName => "Marie",   :Gender => "Female", :FavoriteColor => "Yellow", :DateOfBirth => "11/07/1867"}
        ]
      end

      it "sorts by two criteria" do
        result = parser.parse(:sort => [[:LastName, :asc], [:LastName, :desc]])
        expect(result).to eql(gender_then_last_name)
      end

      it "sorts by date ascending" do
        result = parser.parse(:sort => [[:LastName, :asc], [:LastName, :desc]])
        expect(result).to eql(birthdate_asc)
      end

      it "sorts by string descending" do
        result = parser.parse(:sort => [[:LastName, :desc]])
        expect(result).to eql(last_name_desc)
      end
    end
  end
end
