module Mpesa
  # Some common HTTP functionality
  module APIOperations
    def build_http(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
      http.verify_mode = ::OpenSSL::SSL::VERIFY_NONE
      http
    end

    def build_request(method, uri)
      headers = { 'Accept': 'application/json' }
      if method == :get
        Net::HTTP::Get.new(uri.request_uri, headers)
      else
        Net::HTTP::Post.new(uri.request_uri, headers)
      end
    end
  end
end
