require 'grape'
require 'tempfile'

class RecordServer < Grape::API
  format :json

  # The requirements for records/:sort don't match to exact columns, so the
  # assumed sorting is this:
  SORT_MAPPING = {
    "gender"        => [[:Gender, :asc]],
    "birthdate"     => [[:DateOfBirth, :asc]],
    "name"          => [[:LastName, :asc], [:FirstName, :asc]],
    "lastname"      => [[:LastName, :asc]],
    "firstname"     => [[:FirstName, :asc]],
    "favoritecolor" => [[:FavoriteColor, :asc]]
  }

  # Get internal data store of records.
  def self.records
    @records
  end

  # Add new records to store.
  def self.add_records(new_records)
    @records ||= []
    @records += new_records
  end

  # Reset store.
  def self.reset
    @records = nil
  end

  resource :records do
    desc "Post a single data line in any of the 3 formats supported by your existing code"
    params do
      requires :data, type: String, desc: "A line of delimited data"
    end
    post do
      tempfile = Tempfile.new("temp")
      tempfile.write params[:data]
      tempfile.rewind

      parser = RecordParser.new(tempfile.path)
      RecordServer.add_records parser.parse
    end

    desc "Returns all records"
    get do
      RecordServer.records
    end

    desc "Returns records sorted by :sort"
    get ":sort" do
      sorter = RecordSorter.new(RecordServer.records)
      sort_order = SORT_MAPPING[params[:sort]]
      sorter.sort(sort_order)
    end
  end
end
