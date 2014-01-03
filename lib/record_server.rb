require 'grape'

class RecordServer < Grape::API
  format :json

  get :test do
    {:text => "Hello, World!"}
  end
end
