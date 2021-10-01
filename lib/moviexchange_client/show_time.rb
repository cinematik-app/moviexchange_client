module MoviexchangeClient

  class ShowTime
    SITE_SHOW_TIMES_PATH = "/mxs/reference-data/v1/sites/:site_id/showtimes"
    SHOW_TIME_PATH = "/mxs/reference-data/v1/showtimes/:show_time_id"
    SITE_SHOW_TIMES_WITH_TICKETS_PATH = "/mxs/reference-data/v1/sites/:site_id/showtimes-with-ticket-types"

    class << self
      # Finds the details for a specific cinema-chain
      # {https://apidocs.moviexchange.com/reference#showtimes-for-a-site}
      # @return MoviexchangeClient::ShowTime
      def find_by_show_time_id(id)
        response = MoviexchangeClient::Connection.get_json(SHOW_TIME_PATH, { show_time_id: id })
        new(response)
      end

      # Finds the details for a specific cinema-chain
      # {https://apidocs.moviexchange.com/reference#showtimes-for-a-site}
      # @return MoviexchangeClient::ShowTime
      def find_by_site_id(id)
        response = MoviexchangeClient::Connection.get_json(SITE_SHOW_TIMES_PATH, { site_id: id })
        response.map { |t| new(t) }
      end

      # Finds the details for a specific cinema-chain
      # {https://apidocs.moviexchange.com/reference#showtimes-for-a-site-including-ticket-types-1}
      # @return MoviexchangeClient::ShowTime
      def find_with_ticket_types_by_site_id(id)
        response = MoviexchangeClient::Connection.get_json(SITE_SHOW_TIMES_WITH_TICKETS_PATH, { site_id: id })
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
