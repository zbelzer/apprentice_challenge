require 'spec_helper'

describe RecordServer do
  let(:einstein) { {:LastName => "Einstein", :FirstName => "Albert",  :Gender => "Male",   :FavoriteColor => "Green",  :DateOfBirth => Date.parse("1879-03-14")} }

  include Rack::Test::Methods

  def app
    RecordServer
  end

  describe "POST /records" do
    it "creates a new record for CSV formatted line" do
      einstein = sample_from_fixture('test.csv', 1)
      post_json "/records", {:data => einstein}

      last_response.status.should == 200
      expect(json_response).to have(1).record
      json_response[0].should == einstein.to_json
    end
  end

  describe "GET /records" do
    it "gets all records" do
      get_json "/records"
      last_response.status.should == 200
      expect(json_response).to have(1).record
    end
  end
end
