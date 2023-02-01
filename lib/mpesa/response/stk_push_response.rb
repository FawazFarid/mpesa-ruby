module Mpesa
  class StkPushResponse < Response
    def success?
      super && self.response_code == '0'
    end
  end
end
