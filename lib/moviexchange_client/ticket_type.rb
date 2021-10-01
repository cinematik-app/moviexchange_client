module MoviexchangeClient

  class TicketType
    CINEMA_CHAIN_SHOWTIME_TICKET_TYPES_PATH = "/mxs/reference-data/v1/cinema-chains/:cinema_chain_id/showtimes/:show_time_id/ticket-types"

    class << self
           # Finds the details for a specific cinema-chain
      # {https://apidocs.moviexchange.com/reference#showtimes-for-a-site-including-ticket-types-1}
      # @return MoviexchangeClient::ShowTime
      def find_with_ticket_types_by_chain_and_showtime_id(cinema_chain_id, show_time_id)
        response = MoviexchangeClient::Connection.get_json(CINEMA_CHAIN_SHOWTIME_TICKET_TYPES_PATH, { cinema_chain_id: cinema_chain_id,  show_time_id: show_time_id})
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
