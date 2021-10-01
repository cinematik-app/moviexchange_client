module MoviexchangeClient
  class Order
    CINEMA_CHAIN_ORDERS_PATH = "/mxt/ticketing/v1/cinema-chains/:cinema_chain_id/orders"
    CINEMA_CHAIN_ORDER_CUSTOMER_PATH = "/mxt/ticketing/v1/cinema-chains/:cinema_chain_id/orders/:order_id/customer"
    CINEMA_CHAIN_ORDER_PATH = "/mxt/ticketing/v1/cinema-chains/:cinema_chain_id/orders/:order_id"

    class << self
      # Finds the details for a specific cinema-chain
      # {https://apidocs.moviexchange.com/reference#sites-for-cinema-chain-1 }
      # @return MoviexchangeClient::Site
      def find_by_order_id(cinema_chain_id, order_id)
        response = MoviexchangeClient::Connection.get_json(CINEMA_CHAIN_ORDER_PATH, { cinema_chain_id: cinema_chain_id, order_id: order_id })
        new(response)
      end

      # {https://apidocs.moviexchange.com/reference#create-order}
      # @return MoviexchangeClient::Order
      def create_with_tickets_by_cinema_chain_id(cinema_chain_id, tickets_array)
        post_data = {
          "ticketTypes" => tickets_array
        }

        response = MoviexchangeClient::Connection.post_json(CINEMA_CHAIN_ORDERS_PATH, params: { cinema_chain_id: cinema_chain_id }, body: post_data)
        new(response)
      end

      # {https://apidocs.moviexchange.com/reference#set-customer-details}
      # @return {status: 204}
      def set_customer_details_by_cinema_chain_id(cinema_chain_id, order_id, customer_details)
        post_data = customer_details

        response = MoviexchangeClient::Connection.post_json(CINEMA_CHAIN_ORDER_CUSTOMER_PATH, params: { cinema_chain_id: cinema_chain_id, order_id: order_id }, body: post_data)
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
