require 'forwardable'
require 'mpesa/config/validator'

module Mpesa
  # Contains all the options that you can use to configure an Mpesa instance.
  #
  # @api public
  # @since v0.1.0
  class Config
    extend Forwardable

    SANDBOX_API_BASE = 'https://sandbox.safaricom.co.ke/'.freeze

    LIVE_API_BASE = 'https://api.safaricom.co.ke/'.freeze

    # This passkey is for testing purposes only on sandbox. For production, you should use your own passkey
    # that you get from Safaricom.
    SANDBOX_PASSKEY = 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919'.freeze

    # @return [String] your app's client key. This value *must* be set.
    # @api public
    attr_accessor :consumer_key

    # @return [String] your app's client secret. This value *must* be set.
    # @api public
    attr_accessor :consumer_secret

    # @return [String] the environment your M-Pesa app is running in
    # @api public
    attr_accessor :environment

    # @return [String] the host, which is the base url for the exposed
    # API endpoints
    # @api public
    attr_accessor :host

    # @return [String] the passkey, which is used together Business Shortcode and Timestamp
    # to generate the password for the STK Push request
    # @api public
    attr_accessor :passkey

    def_delegators :validator, :valid?, :errors

    def initialize(user_config = {})
      @environment = 'sandbox'
      @consumer_key = user_config[:consumer_key]
      @consumer_secret = user_config[:consumer_secret]
      @passkey = user_config[:passkey]
    end

    def validator
      @validator ||= Config::Validator.new(self)
    end

    def host
      @host ||= begin
        @environment == 'live' ? LIVE_API_BASE : SANDBOX_API_BASE
      end
    end

    def passkey
      return SANDBOX_PASSKEY if @environment == 'sandbox' && @passkey.nil?

      @passkey
    end
  end
end
