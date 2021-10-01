$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
RSPEC_ROOT = File.dirname(__FILE__)
GEM_ROOT = File.expand_path("..", RSPEC_ROOT)

require 'rspec'
require 'webmock/rspec'
require "moviexchange_client"
require 'vcr'
require 'rr'
require 'pry'

Dir["#{RSPEC_ROOT}/support/**/*.rb"].each {|f| require f}

VCR.configure do |c|
  c.cassette_library_dir = "#{RSPEC_ROOT}/fixtures/vcr_cassettes"
  c.hook_into :webmock
end

RSpec.configure do |config|
  config.mock_with :rr
  config.after(:each) do
    MoviexchangeClient::Config.reset!
  end

  config.around(:each, live: true) do |example|
    VCR.turn_off!
    WebMock.disable!
    example.run
    WebMock.enable!
    VCR.turn_on!
  end

  config.extend CassetteHelper
  config.extend TestsHelper
end
