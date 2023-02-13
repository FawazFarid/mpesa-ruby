module Mpesa
  # B2C = Business to Customer
  # B2C is used to make payments from a Business to Customers (Pay Outs).
  # Also known as Bulk Disbursements it is used in several scenarios by businesses that require to either make Salary Payments,
  # Cashback payments, Promotional Payments(e.g. betting winning payouts), winnings, financial institutions withdrawal of funds, loan disbursements etc.
  # @see https://developer.safaricom.co.ke/Documentation

  B2C_URL = 'mpesa/b2c/v1/paymentrequest'.freeze
  COMMAND_SALARY_PAYMENT = 'SalaryPayment'.freeze
  COMMAND_BUSINESS_PAYMENT = 'BusinessPayment'.freeze
  COMMAND_PROMOTION_PAYMENT = 'PromotionPayment'.freeze

  class B2C
    include APIOperations

    # @see Mpesa.b2c
    def perform(params = {})
      config = Mpesa.configuration

      url_string = "#{config.host}#{B2C_URL}"
      uri = URI(url_string)

      headers = { 'Content-Type' => 'application/json' }
      request = build_request(:post, uri, headers)

      request.body = {
        'InitiatorName': params.dig(:initiator_name) || config.initiator_name,
        'SecurityCredential': params.dig(:security_credential),
        'CommandID': params.dig(:command_id),
        'Amount': params.dig(:amount),
        'PartyA': config.shortcode,
        'PartyB': params.dig(:party_b),
        'Remarks': params.dig(:remarks),
        'QueueTimeOutURL': params.dig(:queue_timeout_url) || config.queue_timeout_url,
        'ResultURL': params.dig(:result_url) || config.result_url,
        'Occasion': params.dig(:occasion)
      }.to_json

      # Make request
      http = build_http(uri)
      response = http.request(request)

      # Parse response
      Response.new(response)
    end
  end
end