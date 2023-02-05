RSpec.describe Mpesa::Config do
  before(:each) do
    Mpesa.configuration = nil
  end

  context 'when consumer_key is configured' do
    it 'returns configured value' do
      consumer_key = 'mYcOnSuMeRk3Y'
      Mpesa.configure { |config| config.consumer_key = consumer_key }
      expect(Mpesa.configuration.consumer_key).to eq consumer_key
    end
  end

  context 'when consumer_secret is configured' do
    it 'returns configured value' do
      consumer_secret = 'MyVery5ecureConsumerS3cr3t'
      Mpesa.configure { |config| config.consumer_secret = consumer_secret }
      expect(Mpesa.configuration.consumer_secret).to eq consumer_secret
    end
  end

  context 'environment is not specified' do
    it 'defaults to sandbox' do
      expect(Mpesa.configuration.environment).to eq 'sandbox'
    end

    it 'host defaults to sandbox api base' do
      expect(Mpesa.configuration.host).to eq described_class::SANDBOX_API_BASE
    end
  end

  context 'environment is specified' do
    context 'when environment is set to sandbox' do
      sandbox_env = 'sandbox'

      before(:each) do
        Mpesa.configure { |config| config.environment = sandbox_env }
      end

      it { expect(Mpesa.configuration.environment).to eq sandbox_env }

      it 'sets host to the Mpesa sandbox API' do
        expect(Mpesa.configuration.host).to eq described_class::SANDBOX_API_BASE
      end
    end

    context 'when environment is set to :live' do
      live_env = 'live'

      before(:each) do
        Mpesa.configure { |config| config.environment = live_env }
      end

      it { expect(Mpesa.configuration.environment).to eq live_env }
      it 'sets host to the Mpesa Live API' do
        expect(Mpesa.configuration.host).to eq described_class::LIVE_API_BASE
      end
    end
  end

  context 'when passkey is configured' do
    it 'returns configured value' do
      passkey = 'MyVery5ecurePasskey'
      Mpesa.configure { |config| config.passkey = passkey }
      expect(Mpesa.configuration.passkey).to eq passkey
    end
  end

  context 'when passkey is not configured' do
    context 'when environment is set to sandbox' do
      it 'returns the sandbox passkey' do
        expect(Mpesa.configuration.passkey).to eq described_class::SANDBOX_PASSKEY
      end
    end

    context 'when environment is set to live' do
      it 'returns nil' do
        Mpesa.configure { |config| config.environment = 'live' }
        expect(Mpesa.configuration.passkey).to be_nil
      end
    end
  end

  context 'validation' do
    context 'with valid params' do
      let(:config) do
        Mpesa.configure do |config|
          config.consumer_key = 'mYcOnSuMeRk3Y'
          config.consumer_secret = 'MyVery5ecureConsumerS3cr3t'
        end
      end

      it 'returns true' do
        expect(config.valid?).to be true
        expect(config.errors).to eql({})
      end
    end

    context 'with invalid params' do
      let(:config) do
        Mpesa.configure do |config|
          config.consumer_key = 'mYcOnSuMeRk3Y'
          config.consumer_secret = nil
        end
      end

      it 'returns false' do
        expect(config.valid?).to be false
      end
    end
  end
end
