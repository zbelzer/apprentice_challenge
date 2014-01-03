module JsonMacros
  def json_response
    json_body = JSON.parse(last_response.body)

    if json_body.is_a?(Hash)
      json_body.with_indifferent_access
    else
      json_body.map(&:with_indifferent_access)
    end
  end

  def get_json(uri, params = {}, env = {}, &block)
    get(uri, params.merge(:format => :json), env)
  end

  def put_json(uri, params = {}, env = {}, &block)
    put(uri, params.merge(:format => :json), env)
  end

  def post_json(uri, params = {}, env = {}, &block)
    post(uri, params.merge(:format => :json), env)
  end

  def delete_json(uri, params = {}, env = {}, &block)
    delete(uri, params.merge(:format => :json), env)
  end
end

RSpec.configure {|config| config.include(JsonMacros)}
