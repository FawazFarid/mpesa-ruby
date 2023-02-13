require 'mpesa/api_operations'
require 'mpesa/config'
require 'mpesa/oauth'
require 'mpesa/response'
require 'mpesa/response/stk_push_response'
require 'mpesa/stk_push'
require 'mpesa/version'

module Mpesa
  class << self
     # @return [Mpesa::Config] Mpesa's current configuration
     def configuration
      @configuration ||= Config.new
    end

    # Set Config's configuration
    # @param config [Mpesa::Config]
    def configuration=(config)
      @configuration = config
    end

    # Modify Mpesa's current configuration
    # @yieldparam [Mpesa::Config] config current Mpesa config
    # ```
    # Mpesa.configure do |config|
    #   config.environment = live
    # end
    # ```
    def configure
      yield configuration
      configuration
    end

    def stk_pusher
      @stk_pusher ||= StkPush.new
    end

    # @param params [Hash] params to be passed to the API
    # @return [Mpesa::Response::StkPushResponse] response from the API
    def stk_push(params = {})
      stk_pusher.perform(params)
    end
    alias lipa_na_mpesa stk_push

    # @param params [Hash] params to be passed to the API
    # @return [Mpesa::Response] response from the API
    def b2c(params = {})
      B2C.new.perform(params)
    end
  end
end
