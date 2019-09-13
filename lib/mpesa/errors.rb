module Mpesa
  # MpesaError is the base error from which all other more specific Mpesa
  # errors derive.
  class MpesaError < StandardError
  end

  # AuthenticationError is raised when invalid credentials are used to connect
  # to M-PESA's servers.
  class AuthenticationError < MpesaError
  end

  # APIConnectionError is raised in the event that the SDK can't connect to
  # M-PESA's servers. That can be for a variety of different reasons from a
  # downed network to a bad TLS certificate.
  class APIConnectionError < MpesaError
  end

  # APIError is a generic error that may be raised in cases where none of the
  # other named errors cover the problem. It could also be raised in the case
  # that a new error has been introduced in the API, but this version of the
  # gem doesn't know how to handle it.
  class APIError < MpesaError
  end
end
