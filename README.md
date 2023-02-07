# Mpesa

> ⚠️ This gem is under development and still at early stages. 

The Mpesa Ruby library provides access to the various APIs
(https://developer.safaricom.co.ke/apis-explorer) M-PESA offers
for developers working on applications written in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mpesa-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mpesa-ruby

## Configuration

The library needs to be configured with your M-PESA application's Consumer Key and Consumer Secret key which is
available in your [M-PESA Apps Dashboard]('https://developer.safaricom.co.ke/user/me/apps'). Click on your App and navigate
to the keys tab.

Set `consumer_key` and `consumer_secret` to their respective values:

```ruby
require "mpesa-ruby"


Mpesa.configure do |config|
  config.consumer_key = 'mYcOnSuMeRk3Y'
  config.consumer_secret = 'MyVery5ecureConsumerS3cr3t'

  # Optional
  config.environment = :live # Defaults to :sandbox

  # STK Push configurations
  config.passkey = 'MyVeryS3cr3tP@ssk3y' # Required for STK Push live environment, defaults to the sandbox passkey for sandbox environment
end

# Make STK Push Request (Paybill)
Mpesa.stk_push({
  business_short_code: 174379,
  transaction_type: Mpesa::CUSTOMER_PAYBILL_ONLINE,
  amount: 1,
  party_a: 254708374149,
  party_b: 174379,
  phone_number: 254708374149,
  callback_url: "https://mydomain.com/path",
  account_reference: "CompanyXLTD",
  transaction_desc: "Payment of X"
})

# Make STK Push Request (Buy Goods and Services)
Mpesa.stk_push({
  business_short_code: 174379,
  transaction_type: Mpesa::CUSTOMER_BUY_GOODS_ONLINE,
  amount: 1,
  party_a: 254708374149,
  party_b: 174379,
  phone_number: 254708374149,
  callback_url: "https://mydomain.com/path",
  account_reference: "CompanyXLTD",
  transaction_desc: "Payment of X"
})

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/FawazFarid/mpesa-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
