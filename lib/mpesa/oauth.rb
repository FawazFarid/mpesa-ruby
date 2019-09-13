require 'openssl'

module Mpesa
  # OAuth executes requests against the M-PESA API authentication endpoints and
  # allows a user to generate an access token for future API calls
  class OAuth
    GENERATE_TOKEN_URL = '/oauth/v1/generate'.freeze
    GRANT_TYPE_CLIENT_CREDENTIALS = 'client_credentials'.freeze

    def self.token
      config = Mpesa.configuration
      uri = URI("#{config.host}#{GENERATE_TOKEN_URL}?grant_type=#{GRANT_TYPE_CLIENT_CREDENTIALS}")
      headers = { 'Accept': 'application/json' }

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
      http.verify_mode = ::OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(uri.request_uri, headers)
      request.basic_auth(config.consumer_key, config.consumer_secret)

      # Send the request
      response = http.request(request)
      response_json = JSON.parse(response.body)

      response_json['access_token']
    end
  end
end
