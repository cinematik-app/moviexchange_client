module MoviexchangeClient

  class Film
    CINEMA_CHAIN_FILMS_PATH = "/mxs/reference-data/v1/cinema-chains/:cinema_chain_id/films"
    FILM_PATH = "/mxs/reference-data/v1/films/:film_id"

    class << self
      # Finds the details for a specific cinema-chain
      # {https://apidocs.moviexchange.com/reference#films-for-a-cinema-chain}
      # @return MoviexchangeClient::Film
      def find_by_film_id(id)
        response = MoviexchangeClient::Connection.get_json(FILM_PATH, { film_id: id })
        new(response)
      end

      # Finds the details for a specific cinema-chain
      # {https://apidocs.moviexchange.com/reference#films-for-a-cinema-chain}
      # @return MoviexchangeClient::Film
      def find_by_cinema_chain_id(id)
        response = MoviexchangeClient::Connection.get_json(CINEMA_CHAIN_FILMS_PATH, { cinema_chain_id: id })
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
