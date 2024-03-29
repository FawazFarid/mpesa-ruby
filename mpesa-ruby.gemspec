lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mpesa/version'

Gem::Specification.new do |spec|
  spec.name          = 'mpesa-ruby'
  spec.version       = Mpesa::VERSION
  spec.authors       = ['Fawaz Farid']
  spec.email         = ['fawwazally@gmail.com']

  spec.summary       = 'Gem for interacting with M-PESA APIs'
  spec.description   = <<-DESC
    This gem provides access to the various APIs
    (https://developer.safaricom.co.ke/apis-explorer) M-PESA offers
    for developers working applications written in Ruby.
  DESC

  spec.homepage      = 'https://github.com/FawazFarid/mpesa-ruby/'
  spec.license       = 'MIT'

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/FawazFarid/mpesa-ruby/'
  spec.metadata['changelog_uri'] = 'https://github.com/FawazFarid/mpesa-ruby/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem,
  # that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.3'
  spec.add_development_dependency 'pry-byebug', '~> 3.4'
  spec.add_development_dependency 'rake', ">= 12.3.3"
  spec.add_development_dependency 'rb-readline', '~> 0.5.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 3.7'
end
