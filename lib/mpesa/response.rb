module Mpesa
  class Response
    # @return [Integer] HTTP code returned when the request has succeeded
    OK = 200.freeze

    # @return [Integer] HTTP code returned when the request has been fulfilled
    #   and resulted in a new resource being created
    CREATED = 201.freeze
    attr_reader :code, :raw_response, :parsed_response

    # raw_response - Net::HTTP::HTTPResponse
    def initialize(raw_response)
      @raw_response = raw_response
      @parsed_response ||= parse!
    end

    def success?
      raw_response.code == OK || raw_response.code == CREATED
    end

    def error?
      !success?
    end

    # Parse the response body, convert the keys to snake case and define a method dynamically for each key
    def parse!
      @code = @raw_response.code.to_i
      body = @raw_response.body

      parsed_body = JSON.parse(body)

      parsed_response = Hash.new
      parsed_body.each_pair do |key, value|
        # convert the key to snake case
        key = key.dup.underscore!
        parsed_response[key] = value

        # define a method for the key to access the value
        define_singleton_method(key) do
          return value
        end
      end

      parsed_response
    end
  end
end


# underscore! method is not available outside of Rails, had to write a simple implementation
class String
  # ruby mutation methods have the expectation to return self if a mutation occurred, nil otherwise. (see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-gsub-21)
  def underscore!
    gsub!(/(.)([A-Z])/,'\1_\2')
    downcase!
  end
end
