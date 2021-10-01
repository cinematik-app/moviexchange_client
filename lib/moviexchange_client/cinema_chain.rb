module MoviexchangeClient

  class CinemaChain
    CINEMA_CHAINS_PATH = "/mxs/reference-data/v1/cinema-chains"
    CINEMA_CHAIN_PATH = "/mxs/reference-data/v1/cinema-chains/:cinema_chain_id"

    class << self
      # Lists the cinema chains
      # {https://apidocs.moviexchange.com/reference#get-cinema-chains)
      # @return [MoviexchangeClient::CinemaChain] array of cinema chains
      def list
        response = MoviexchangeClient::Connection.get_json(CINEMA_CHAINS_PATH, {})
        response.map { |t| new(t) }
      end

      # Finds the details for a specific cinema-chain
      # {https://apidocs.moviexchange.com/reference#get-cinema-chains }
      # @return MoviexchangeClient::CinemaChain
      def find_by_cinema_chain_id(id)
        response = MoviexchangeClient::Connection.get_json(CINEMA_CHAIN_PATH, { cinema_chain_id: id })
        new(response)
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
