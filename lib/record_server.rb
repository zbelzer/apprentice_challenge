require 'grape'

class RecordServer < Grape::API
  format :json

  helpers do
    def records
      @records ||= []
    end
  end

  resource :records do
    desc "Post a single data line in any of the 3 formats supported by your existing code"
    params do
      requires :data, type: String, desc: "A line of delimited data"
    end
    post do
      records
    end

    desc "Returns records sorted by {sort}"
    get do
      records
    end
  end
end
