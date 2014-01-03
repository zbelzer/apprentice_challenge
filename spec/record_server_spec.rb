require 'spec_helper'

describe RecordServer do
  include Rack::Test::Methods

  let(:einstein_record) do
    {"LastName" => "Einstein", "FirstName" => "Albert",  "Gender" => "Male", "FavoriteColor" => "Green", "DateOfBirth" => "1879-03-14"}
  end

  def app
    RecordServer
  end

  def import_from_file(file, row)
    row = sample_from_fixture(file, row)
    post_json "/records", {:data => row}
  end

  before do
    app.reset
  end

  describe "POST /records" do
    it "creates a new record for CSV formatted line" do
      einstein = sample_from_fixture('test.csv', 0)
      post_json "/records", {:data => einstein}

      last_response.status.should == 201
    end

    it "can create multiple rows" do
      (0..4).each { |i| import_from_file('test.csv', i) }

      get_json "/records"
      last_response.status.should == 200
      expect(json_response).to have(5).records
    end
  end

  describe "GET /records" do
    it "gets all records" do
      import_from_file('test.csv', 0)

      get_json "/records"
      last_response.status.should == 200
      expect(json_response).to have(1).record
      expect(json_response[0]).to eq(einstein_record)
    end
  end
end
