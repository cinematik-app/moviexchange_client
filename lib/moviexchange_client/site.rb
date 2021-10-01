module MoviexchangeClient
  class Site
    CINEMA_CHAIN_SITES_PATH = "/mxs/reference-data/v1/cinema-chains/:cinema_chain_id/sites"
    SITES_PATH = "/mxs/reference-data/v1/sites/:site_id"

    class << self
      # Finds the details for a specific cinema-chain
      # {https://apidocs.moviexchange.com/reference#sites-for-cinema-chain-1 }
      # @return MoviexchangeClient::Site
      def find_by_site_id(id)
        response = MoviexchangeClient::Connection.get_json(SITES_PATH, { site_id: id })
        new(response)
      end

      # Finds the details for a specific cinema-chain
      # {https://apidocs.moviexchange.com/reference#get-cinema-chains }
      # @return MoviexchangeClient::CinemaChain
      def find_by_cinema_chain_id(id)
        response = MoviexchangeClient::Connection.get_json(CINEMA_CHAIN_SITES_PATH, { cinema_chain_id: id })
        response.map { |t| new(t) }
      end
    end

    attr_reader :properties

    def initialize(response_hash)
      @properties = response_hash #no need to parse anything, we have properties
    end

    def [](property)
      @properties[property]
    end
  end
end
