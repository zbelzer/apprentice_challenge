require_relative 'spec_helper'

describe RecordParser do
  describe "parse" do
    context "extraction" do
      let(:correct_result) do
        [
          {:LastName => "Einstein", :FirstName => "Albert",  :Gender => "Male",   :FavoriteColor => "Green",  :DateOfBirth => Date.parse("1879-03-14")},
          {:LastName => "Darwin",   :FirstName => "Charles", :Gender => "Male",   :FavoriteColor => "Blue",   :DateOfBirth => Date.parse("1809-02-12")},
          {:LastName => "Curie",    :FirstName => "Marie",   :Gender => "Female", :FavoriteColor => "Yellow", :DateOfBirth => Date.parse("1867-11-07")},
          {:LastName => "Lovelace", :FirstName => "Ada",     :Gender => "Female", :FavoriteColor => "Purple", :DateOfBirth => Date.parse("1815-12-10")},
          {:LastName => "Turing",   :FirstName => "Alan",    :Gender => "Male",   :FavoriteColor => "Red",    :DateOfBirth => Date.parse("1912-06-03")}
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
          {:LastName => "Curie",    :FirstName => "Marie",   :Gender => "Female", :FavoriteColor => "Yellow", :DateOfBirth => Date.parse("1867-11-07")},
          {:LastName => "Lovelace", :FirstName => "Ada",     :Gender => "Female", :FavoriteColor => "Purple", :DateOfBirth => Date.parse("1815-12-10")},
          {:LastName => "Darwin",   :FirstName => "Charles", :Gender => "Male",   :FavoriteColor => "Blue",   :DateOfBirth => Date.parse("1809-02-12")},
          {:LastName => "Einstein", :FirstName => "Albert",  :Gender => "Male",   :FavoriteColor => "Green",  :DateOfBirth => Date.parse("1879-03-14")},
          {:LastName => "Turing",   :FirstName => "Alan",    :Gender => "Male",   :FavoriteColor => "Red",    :DateOfBirth => Date.parse("1912-06-03")}
        ]
      end

      let(:birthdate_asc) do
        [
          {:LastName => "Darwin",   :FirstName => "Charles", :Gender => "Male",   :FavoriteColor => "Blue",   :DateOfBirth => Date.parse("1809-02-12")},
          {:LastName => "Lovelace", :FirstName => "Ada",     :Gender => "Female", :FavoriteColor => "Purple", :DateOfBirth => Date.parse("1815-12-10")},
          {:LastName => "Curie",    :FirstName => "Marie",   :Gender => "Female", :FavoriteColor => "Yellow", :DateOfBirth => Date.parse("1867-11-07")},
          {:LastName => "Einstein", :FirstName => "Albert",  :Gender => "Male",   :FavoriteColor => "Green",  :DateOfBirth => Date.parse("1879-03-14")},
          {:LastName => "Turing",   :FirstName => "Alan",    :Gender => "Male",   :FavoriteColor => "Red",    :DateOfBirth => Date.parse("1912-06-03")}
        ]
      end

      let(:last_name_desc) do
        [
          {:LastName => "Turing",   :FirstName => "Alan",    :Gender => "Male",   :FavoriteColor => "Red",    :DateOfBirth => Date.parse("1912-06-03")},
          {:LastName => "Lovelace", :FirstName => "Ada",     :Gender => "Female", :FavoriteColor => "Purple", :DateOfBirth => Date.parse("1815-12-10")},
          {:LastName => "Einstein", :FirstName => "Albert",  :Gender => "Male",   :FavoriteColor => "Green",  :DateOfBirth => Date.parse("1879-03-14")},
          {:LastName => "Darwin",   :FirstName => "Charles", :Gender => "Male",   :FavoriteColor => "Blue",   :DateOfBirth => Date.parse("1809-02-12")},
          {:LastName => "Curie",    :FirstName => "Marie",   :Gender => "Female", :FavoriteColor => "Yellow", :DateOfBirth => Date.parse("1867-11-07")}
        ]
      end

      it "sorts by two criteria" do
        result = parser.parse(:sort => [[:Gender, :asc], [:LastName, :asc]])
        expect(result).to eql(gender_then_last_name)
      end

      it "sorts by date ascending" do
        result = parser.parse(:sort => [[:DateOfBirth, :asc]])
        expect(result).to eql(birthdate_asc)
      end

      it "sorts by string descending" do
        result = parser.parse(:sort => [[:LastName, :desc]])
        expect(result).to eql(last_name_desc)
      end
    end
  end
end
