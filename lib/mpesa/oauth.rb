require 'openssl'

module Mpesa
  # OAuth executes requests against the M-PESA API authentication endpoints and
  # allows a user to generate an access token for future API calls
  class OAuth
    extend APIOperations

    GENERATE_TOKEN_URL = '/oauth/v1/generate'.freeze
    GRANT_TYPE_CLIENT_CREDENTIALS = 'client_credentials'.freeze

    def self.token
      config = Mpesa.configuration
      url_string = "#{config.host}#{GENERATE_TOKEN_URL}"
      url_string << "?grant_type=#{GRANT_TYPE_CLIENT_CREDENTIALS}"
      uri = URI(url_string)

      request = build_request(:get, uri)
      request.basic_auth(config.consumer_key, config.consumer_secret)

      # Send the request
      http = build_http(uri)
      response = http.request(request)
      response_json = JSON.parse(response.body)

      response_json['access_token']
    end
  end
end
