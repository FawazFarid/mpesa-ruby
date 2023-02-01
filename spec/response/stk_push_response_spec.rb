RSpec.describe Mpesa::StkPushResponse do
  let(:raw_response) do
    double('raw_response', code: 200, body: {
      "MerchantRequestID": "29115-34620561-1",
      "CheckoutRequestID": "ws_CO_191220191020363925",
      "ResponseCode": "0",
      "ResponseDescription": "Success. Request accepted for processing",
      "CustomerMessage": "Success. Request accepted for processing" }.to_json
    )
  end
  let(:response) { described_class.new(raw_response) }

  describe '#success?' do
    context 'with successful API response' do
      context 'ResponseCode is 0' do
        it 'returns true' do
          expect(response.success?).to be_truthy
        end
      end

      context 'ResponseCode is not 0' do
        it 'returns false' do
          allow(response).to receive(:response_code).and_return("404.001.03")
          expect(response.success?).to be_falsey
        end
      end
    end

    context 'with failed API response' do
      it 'returns false' do
        allow(raw_response).to receive(:code).and_return(400)
        expect(response.success?).to be_falsey
      end
    end
  end

  describe '#error?' do
    it 'returns true if the response code is not 200' do
      allow(raw_response).to receive(:code).and_return(400)
      expect(response.error?).to be_truthy
    end

    it 'returns false if the response code is 200' do
      expect(response.error?).to be_falsey
    end
  end

  describe 'methods' do
    it 'returns correct values' do
      expect(response.merchant_request_id).to eq("29115-34620561-1")
      expect(response.checkout_request_id).to eq("ws_CO_191220191020363925")
      expect(response.response_code).to eq("0")
      expect(response.response_description).to eq("Success. Request accepted for processing")
      expect(response.customer_message).to eq("Success. Request accepted for processing")
    end
  end
end