require 'spec_helper'

describe RecordServer do
  include Rack::Test::Methods

  let(:einstein_record) do
    {"LastName" => "Einstein", "FirstName" => "Albert",  "Gender" => "Male", "FavoriteColor" => "Green", "DateOfBirth" => "1879-03-14"}
  end

  def app
    RecordServer
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
  end

  describe "GET /records" do
    it "gets all records" do
      einstein = sample_from_fixture('test.csv', 0)
      post_json "/records", {:data => einstein}

      get_json "/records"
      last_response.status.should == 200
      expect(json_response).to have(1).record
      expect(json_response[0]).to eq(einstein_record)
    end
  end
end
