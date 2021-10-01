require "moviexchange_client/version"
require 'active_support'
require 'active_support/core_ext'
require 'httparty'
require 'moviexchange_client/exceptions'
require 'moviexchange_client/config'
require 'moviexchange_client/connection'
require 'moviexchange_client/cinema_chain'
require 'moviexchange_client/site'
require 'moviexchange_client/film'
require 'moviexchange_client/show_time'
require 'moviexchange_client/ticket_type'
require 'moviexchange_client/order'

module MoviexchangeClient
  def self.configure(config={})
    MoviexchangeClient::Config.configure(config)
  end
end

