module HyvesOauth
  class Client
    def initialize(options = {})
      @consumer_key = options[:consumer_key]
      @consumer_secret = options[:consumer_secret]
    end
    
    def request_token(options = {})
      consumer.get_request_token(options, {"strict_oauth_spec_response" => "true", "ha_method" => "auth.requesttoken", "methods" => "wwws.create"})
    end
  private
    def consumer
      @consumer ||= OAuth::Consumer.new(@consumer_key, @consumer_secret, { 
        :site => "http://data.hyves-api.nl",
        :request_token_path => "/",
        :http_method => :post
      })
    end
  end
end