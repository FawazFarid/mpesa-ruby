require 'base64'

module Mpesa
  # # STK = SIM (Subscriber Identity Module) Toolkit
  # STKPush is used to initiate a STK Push request on behalf of a customer.``
  # STK Push (A.K.A LIPA NA M-PESA ONLINE API) is a Merchant/Business initiated C2B (Customer to Business) Payment.
  # @see https://developer.safaricom.co.ke/Documentation

  CUSTOMER_PAYBILL_ONLINE = 'CustomerPayBillOnline'.freeze
  CUSTOMER_BUY_GOODS_ONLINE = 'CustomerBuyGoodsOnline'.freeze
  STK_PUSH_URL = 'mpesa/stkpush/v1/processrequest'.freeze

  class StkPush
    include APIOperations

    # @see Mpesa.stk_push
    def perform(params = {})
      config = Mpesa.configuration

      url_string = "#{config.host}#{STK_PUSH_URL}"
      uri = URI(url_string)

      headers = { 'Content-Type' => 'application/json' }
      request = build_request(:post, uri, headers)

      timestamp = Time.now.strftime('%Y%m%d%H%M%S')
      business_short_code = params.dig(:business_short_code) || config.business_short_code


      # base64 encode combination of Shortcode+Passkey+Timestamp
      password = Base64.strict_encode64("#{business_short_code}#{config.passkey}#{timestamp}")

      # get token and use it to set the Authorization header
      token = OAuth.token
      request['Authorization'] = "Bearer #{token}"

      request.body = {
        'BusinessShortCode': business_short_code,
        'Password': password,
        'Timestamp': timestamp,
        'TransactionType': params.dig(:transaction_type),
        'Amount':  params.dig(:amount),
        'PartyA': params.dig(:party_a) || params.dig(:phone_number),
        'PartyB': params.dig(:party_b) || business_short_code,
        'PhoneNumber': params.dig(:phone_number),
        'CallBackURL': params.dig(:callback_url) || config.callback_url,
        'AccountReference': params.dig(:account_reference),
        'TransactionDesc': params.dig(:transaction_desc)
      }.to_json

      # Make request
      http = build_http(uri)
      response = http.request(request)

      # Parse response
      StkPushResponse.new(response)
    end
  end
end
