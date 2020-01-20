module Mpesa
  # Contains all the options that you can use to configure an Mpesa instance.
  #
  # @api public
  # @since v0.1.0
  class Config
    SANDBOX_API_BASE = 'https://sandbox.safaricom.co.ke'.freeze

    LIVE_API_BASE = 'https://api.safaricom.co.ke'.freeze

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

    def initialize(user_config = {})
      self.environment = 'sandbox'
      self.consumer_key = user_config[:consumer_key]
      self.consumer_secret = user_config[:consumer_secret]
    end

    def host
      @host ||= begin
        @environment == 'live' ? LIVE_API_BASE : SANDBOX_API_BASE
      end
    end
  end

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
  end
end
