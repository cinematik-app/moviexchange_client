require 'logger'
require 'moviexchange_client/connection'

module MoviexchangeClient
  class Config

    CONFIG_KEYS = [
      :username, :password, :auth_url, :base_url, :logger, :access_token, :client_id, :client_secret
    ]
    DEFAULT_LOGGER = Logger.new(nil)

    class << self
      attr_accessor *CONFIG_KEYS

      def configure(config)
        config.stringify_keys!
        @username = config["username"] if config["username"].present?
        @password = config["password"] if config["password"].present?
        @client_secret = config["client_secret"] if config["client_secret"].present?
        @access_token = config["access_token"] if config["access_token"].present?
        @client_id = config["client_id"] || "mx-transact-postman"
        @base_url = config["base_url"] || "https://www.example.com"
        @auth_url = config["auth_url"] || "https://www.example.com"
        @logger = config["logger"] || DEFAULT_LOGGER

        unless (username.present? && password.present? && client_secret.present?) || access_token.present?
          MoviexchangeClient::ConfigurationError.new("You must provide either an access_token or valid username, password and client_secret")
        end

        current_config = self.instance_values.transform_keys(&:to_sym)
        token = MoviexchangeClient::Connection.get_access_token(current_config)

        MoviexchangeClient::Connection.headers("Authorization" => "Bearer #{token}")
        MoviexchangeClient::Connection.headers("MX-Api-Client-Secret" => client_secret)
        self
      end

      def reset!
        @username = nil
        @password = nil
        @base_url = "https://www.example.com"
        @auth_url = "https://www.example.com"
        @logger = DEFAULT_LOGGER
        @access_token = nil
        MoviexchangeClient::Connection.headers({})
      end

      def ensure!(*params)
        params.each do |p|
          raise MoviexchangeClient::ConfigurationError.new("'#{p}' not configured") unless instance_variable_get "@#{p}"
        end
      end
    end

    reset!
  end
end
