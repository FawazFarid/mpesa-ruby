RSpec.describe Mpesa::Config::Validator do
  let(:valid_key) { 'mYcOnSuMeRk3Y' }
  let(:valid_secret) { 'MyVery5ecureConsumerS3cr3t' }
  let(:config) { Mpesa::Config.new(config_params) }

  describe '.run_validations' do
    context 'when config params are valid' do
      let(:config_params) do
        { consumer_key: valid_key, consumer_secret: valid_secret }
      end

      it 'returns the config object' do
        validator = described_class.new(config)
        config_object = validator.run_validations

        expect(config_object).to be_an_instance_of(Mpesa::Config)
        expect(validator.errors).to be_empty
      end
    end

    context 'when consumer_key is an empty string' do
      let(:config_params) do
        { consumer_key: '', consumer_secret: valid_secret }
      end

      it 'should contain an error' do
        validator = described_class.new(config)
        config_object = validator.run_validations

        expect(validator.errors[:consumer_key]).to eq('consumer_key is required')
      end
    end

    context 'when consumer_key is not set' do
      let(:config_params) do
        { consumer_key: nil, consumer_secret: valid_secret }
      end

      it 'throws an error' do
        validator = described_class.new(config)
        config_object = validator.run_validations

        expect(validator.errors[:consumer_key]).to eq('consumer_key is required')
      end
    end

    context 'when consumer_secret is an empty string' do
      let(:config_params) do
        { consumer_key: valid_key, consumer_secret: '' }
      end

      it 'should contain an error' do
        validator = described_class.new(config)
        config_object = validator.run_validations

        expect(validator.errors[:consumer_secret]).to eq('consumer_secret is required')
      end
    end

    context 'when consumer_secret is not set' do
      let(:config_params) do
        { consumer_key: valid_key, consumer_secret: nil }
      end

      it 'should contain an error' do
        validator = described_class.new(config)
        config_object = validator.run_validations

        expect(validator.errors[:consumer_secret]).to eq('consumer_secret is required')
      end
    end
  end
end
