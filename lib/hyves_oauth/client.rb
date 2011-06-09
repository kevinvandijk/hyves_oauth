module HyvesOAuth
  class Client
    def initialize(options = {})
      @consumer_key = options[:consumer_key]
      @consumer_secret = options[:consumer_secret]
      @token = options[:token]
      @secret = options[:secret]

    end
    
    def request_token(options = {})
      @request_token = consumer.get_request_token(options, {"strict_oauth_spec_response" => "true", "ha_method" => "auth.requesttoken", "methods" => "wwws.create,users.getLoggedin"})
    end
    
    def authorize_url
      @request_token.authorize_url.gsub("http://data.hyves-api.nl/oauth/", "http://www.hyves.nl/api/")
    end
    
    def authorize(token, secret, options = {})
      request_token = OAuth::RequestToken.new(consumer, token, secret)
      @access_token = request_token.get_access_token(options, {"strict_oauth_spec_response" => "true", "ha_method" => "auth.accesstoken"})
      @token = @access_token.token
      @secret = @access_token.secret
      @access_token
    end
        
    def update(message, options = {})
      post("/", {"ha_method" => "wwws.create", "emotion" => message, "visibility" => "default"}.merge(options))
    end
    
    def get_logged_in
      post "/", {"ha_method" => "users.getLoggedin"}
    end
  private
    def consumer
      @consumer ||= OAuth::Consumer.new(@consumer_key, @consumer_secret, { 
        :site => "http://data.hyves-api.nl",
        :request_token_path => "/",
        :access_token_path => "/",
        :http_method => :post
      })
    end
    
    def access_token
      @access_token ||= OAuth::AccessToken.new(consumer, @token, @secret)
    end
    
    def post(path, body='', headers={})
      body.merge!("ha_format" => "json")
      headers.merge!("User-Agent" => "hyves_oauth gem v#{HyvesOAuth::VERSION}")
      oauth_response = access_token.post("/1#{path}", body, headers)
      JSON.parse(oauth_response.body)
    end
  end
end
