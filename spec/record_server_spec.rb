require 'spec_helper'

describe RecordServer do
  include Rack::Test::Methods

  def app
    RecordServer
  end

  describe "GET /test" do
    it "returns my test string" do
      get_json "/test"
      last_response.status.should == 200
      json_response[:text].should == "Hello, World!"
    end
  end
end
