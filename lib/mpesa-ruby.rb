require 'mpesa/api_operations'
require 'mpesa/config'
require 'mpesa/oauth'
require 'mpesa/response'
require 'mpesa/response/stk_push_response'
require 'mpesa/stk_push'
require 'mpesa/version'

module Mpesa
  class << self
    attr_writer :stk_pusher
    def stk_pusher
      @stk_pusher ||= StkPush.new
    end

    def stk_push(params = {})
      stk_pusher.perform(params)
    end
    alias lipa_na_mpesa stk_push
    alias lipa_na_mpesa_online stk_push
  end
end
