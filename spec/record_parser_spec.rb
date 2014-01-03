require_relative 'spec_helper'

describe RecordParser do
  describe "parse" do
    context "extraction" do
      let(:correct_result) { [ einstein, darwin, curie, lovelace, turing ] }

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

      it "parses a SSV file" do
        file = path_to_fixture('test.ssv')
        parser = RecordParser.new(file)
        expect(parser.parse).to eql(correct_result)
      end
    end

    context "sorting" do
      let(:parser) { RecordParser.new(path_to_fixture('test.csv')) }

      let(:gender_then_last_name) { [ curie, lovelace, darwin, einstein, turing ] }
      let(:gender_then_color) { [ curie, lovelace, einstein, darwin, turing ] }
      let(:birthdate_asc) { [ darwin, lovelace, curie, einstein, turing ] }
      let(:last_name_desc) { [ turing, lovelace, einstein, darwin, curie ] }

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

      it "handles too many ties" do
        result = parser.parse(:sort => [[:Gender, :asc]])
        expect(result).to eql(gender_then_color)
      end
    end
  end
end
