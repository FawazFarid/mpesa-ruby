RSpec.describe Mpesa::OAuth do
  describe '.token' do
    let!(:config) do
      Mpesa.configure do |config|
        config.consumer_key = 'mYcOnSuMeRk3Y'
        config.consumer_secret = 'MyVery5ecureConsumerS3cr3t'
      end
    end

    it 'should exchange client credentials for an access token' do
      stub_request(:get, config.host + described_class::GENERATE_TOKEN_URL)
        .with(
          basic_auth: [config.consumer_key, config.consumer_secret],
          query: {
            'grant_type': described_class::GRANT_TYPE_CLIENT_CREDENTIALS
          }
        )
        .to_return(
          body: JSON.generate(
            access_token: 'my_secret_access_token',
            expires_in: '3599'
          )
        )

      access_token = described_class.token
      expect(access_token).to eql('my_secret_access_token')
    end
  end
end
