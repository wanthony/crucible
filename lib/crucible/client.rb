require File.join(File.dirname(__FILE__), 'configurable')
require File.join(File.dirname(__FILE__), 'review_client')

class Crucible::Client
  include Crucible::Configurable
  include Crucible::ReviewClient

  def initialize(options = {})
    load_config!

    Crucible::Configurable.keys.each do |key|
      self.instance_variable_set("@#{key}", options[key])
    end
  end

  def get(path, params = {}, options = {})
    request(:get, path, params, options)
  end

  def post(path, params = {}, options = {})
    request(:post, path, params, options)
  end

  def put(path, params = {}, options = {})
    request(:put, path, params, options)
  end

  def delete(path, params = {}, options = {})
    request(:delete, path, params, options)
  end

  private
    def request(method, path, params = {}, options = {})
      JSON.parse RestClient.send(method, "#{endpoint}#{path}.json", params)
    rescue RestClient::BadRequest, RestClient::InternalServerError => e
      JSON.parse e.response
    end
end
