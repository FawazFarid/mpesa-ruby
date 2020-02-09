module Mpesa
  class Config
    # Validator class validates values of Mpesa::Config options.
    # A valid config is a config that guarantees that data can be sent to
    # M-PESA API given its configuration.
    class Validator
      attr_reader :config
      attr_reader :errors

      # @param [Mpesa::Config] config
      def initialize(config)
        @config = config
        @errors = {}
      end

      def run_validations
        unless valid_consumer_key?
          errors[:consumer_key] = "consumer_key is required"
        end

        unless valid_consumer_secret?
          errors[:consumer_secret] = "consumer_secret is required"
        end
        @config
      end

      def valid_consumer_key?
        return false unless config.consumer_key.is_a?(String)
        return false if config.consumer_key.empty?
        true
      end

      def valid_consumer_secret?
        return false unless config.consumer_secret.is_a?(String)
        return false if config.consumer_secret.empty?
        true
      end
    end
  end
end
